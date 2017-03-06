### Test Env:
    ma2test01.ma.platformlab.ibm.com   9.21.55.81 master
    ma2test02.ma.platformlab.ibm.com   9.21.55.81
    ma2test03.ma.platformlab.ibm.com   9.21.55.43
    ma2test04.ma.platformlab.ibm.com   9.21.55.44
    ma2test05.ma.platformlab.ibm.com   9.21.55.45
    ma2test06.ma.platformlab.ibm.com   9.21.55.46
    
    IBM System x3550 M4 Server IBM 2 x Intel Xeon E5-2660 @ 2.20GHz 256GB 8x600GB SAS

### Before we begin
#### 1. Setup passwordless ssh between machines((including the host originally running ssh-keygen)) within the Mesos-Spark cluster
    $ ssh-keygen -t rsa
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub root@<gpfsserver1>


-----------------------------------------------
Apache MESOS v0.28.2 (Spark Session Scheduler 1.6.1 )
-----------------------------------------------
[ ] 1. Make configuration changes in Mesos.

    Login to ma2test01:
    a) Edit startup script:
        /opt/mesos/mesos-0.28.2/scripts/start_master.sh
        /opt/mesos/mesos-0.28.2/scripts/start_slaves.sh
[ ] 2. Make configuration changes in Spark on Mesos
    
    Login to ma2test01:
    a) Edit
        vim /opt/spark/spark-1.6.1/conf/spark-defaults.conf
        vim /opt/spark/spark-1.6.1/conf/spark-env.sh
        Sample changes, not actually apply to current test env:
        {
          "sparkparameters":
          {
            "spark.executor.memory": "8g",
            "spark.eventLog.dir": "/opt/spark/event",
            "spark.executor.cores": "1",
            "spark.port.maxRetries": "512",
            "spark.history.fs.logDirectory": "/opt/spark/event",
          }
        }
        
    b) Copy to all hosts.
        # for i in `seq 1 6`; do echo ma2test0$i; scp -r /opt/spark/spark-1.6.1/conf/spark-defaults.conf ma2test0$i:/opt/spark/spark-1.6.1/conf/ ; done
        # for i in `seq 1 6`; do echo ma2test0$i; scp -r /opt/spark/spark-1.6.1/conf/spark-env.sh ma2test0$i:/opt/spark/spark-1.6.1/conf/ ; done
[ ] 3. Restart Mesos:

    # source /opt/profile.mesos-spark-bench
    # cd /opt/mesos/mesos-0.28.2/scripts/
    # ./stop_slaves.sh
    # ./stop_master.sh
    # ./start_master.sh
    # ./start_slaves.sh
[ ] 4. Restart Spark Master:

    # source /opt/profile.mesos-spark-bench
    # $SPARK_HOME/sbin/stop-master.sh
    # $SPARK_HOME/sbin/start-master.sh

[ ] 5. Startup the Shuffle service on each host: (this does not apply to session scheduler)

    Apache Spark 1.6.1-Haddop 2.6
    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "ps -ef | grep MesosExternalShuffleService | grep -v grep | awk '{print \$2}' | xargs kill -9" ; done
    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "source /opt/profile.mesos-spark-apache-bench; /opt/spark/spark-1.6.1-bin-hadoop2.6/sbin/start-mesos-shuffle-service.sh" ; done
        NOTE: Default port for the Mesos shuffle service is 7337.
    
    Session Scheduler
    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "ps -ef | grep MesosExternalShuffleService | grep -v grep | awk '{print \$2}' | xargs kill -9" ; done
    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "source /opt/profile.mesos-spark-bench; /opt/spark/spark-1.6.1/sbin/start-mesos-shuffle-service.sh" ; done
        NOTE: Default port for the Mesos shuffle service is 7337.
[ ] 6. Verify Mesos services have started:

    Use the GUI: http://ma2test01.ma.platformlab.ibm.com:5050
    Use the CLI:
        # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "ps -ef|grep mesos" ; done
            - Check for mesos-slave and mesos-master
        # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "ps -ef|grep MesosExternalShuffleService" ; done
[ ] 7. Start history server for Mesos.

    # /opt/spark/spark-1.6.1/sbin/start-history-server.sh /opt/spark/event
    To access the history server:
    Open web browser to http://ma2test01.ma.platformlab.ibm.com:18084

[ ] 8. Start the test run for Mesos.

    sample command for single run:
    ./bin/spark-submit --total-executor-cores 1 --executor-memory 512m --name terasort --deploy-mode client --master spark://9.21.55.81:7077 --class IBM_ARL_teraSort /opt/spark/sample/terasort/pc4spark_SparkMulti-UserBenchmark-1-master/ARLTeraSort_v1/STACAuditJar/ibm-arl-terasort_2.10-1.0.jar /home/zjin/terasort/input/ /home/zjin/terasort/output/005 100


    Login as root.
    #source /opt/profile.mesos-spark-bench
    #cd /perf_test/perf_harness
    Run a short warmup run of 2-30-1 before 6-10-10
    #nohup ./step_up_multi_user.sh <steps> <offset> <iterations> spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &
        Where:
            steps: the number of users
            offset: delay in seconds before next user starts submission
            iterations: number of jobs submitted for each user
    Example with 6 users, 10s delay, 10 jobs submitted by each user:
    open sourced spark: # nohup ./step_up_multi_user.sh 6 60 10 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &
    session scheduler:  # nohup ./step_up_multi_user.sh 6 60 10 mesos://9.21.55.81:5050 > /perf_test/perf_data/env_output.log 2>&1 &

-----------------------------
Check STATUS of a current run
-----------------------------
[ ] 1. Tailing one of the driver_output_.log files.

    # cd /perf_test/perf_data
    # grep ERROR driver_output_*
        - Find any errors messages:
            For example, any "SparkUncaughtExceptionHandler" indicates a failed job due to akka configuration
[ ] 2. Check the number of directories created under NFS output directory.

    # ls /SparkBench/Terasort/Output/ | wc -l
        - There should be an output directory created for each Spark job submission.
        - The number should reach <steps> x <iterations>
        - Periodically running the command can give an estimate of the progress
[ ] 3. Check the number of files under spark-events directory (read by the history server).

    # ls -l /opt/spark/event/|wc -l
        - There should always be a file for a successful job indicated by these lines:
            {"Event":"SparkListenerJobEnd","Job ID":0,"Completion Time":1454090875632,"Job Result":{"Result":"JobSucceeded"}}
            {"Event":"SparkListenerJobEnd","Job ID":1,"Completion Time":1454090888666,"Job Result":{"Result":"JobSucceeded"}}
        - The total number of files should equal <steps> x <iterations>
            - If there are less, this indicates there are failed jobs
                # grep "JobSucceeded" /mnt/nfs/conductor/spark-events/*|wc -l
                    -There should be 3600 entries (2 jobs per application)
[ ] 4. Check for the executor memory size and cores:

    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i "ps -ef|grep executor" ; done
[ ] 5. Monitor the master host ma2test01 by running 'nmon' interactively in another window.

----------------
CLEANUP Sequence
----------------

[ ] 0. Run Cleanup script to clean up all directories
    
    #/perf_test/perf_harness/clean_files_and_dirs.sh
[ ] 1. Stop all other Resource Managers.
    
    Login to ma2test01.
    
    b) Mesos:
    # source /opt/profile.mesos-spark-bench
    # /opt/mesos-0.28.2/scripts/stop_slaves.sh
    # /opt/mesos-0.28.2/scripts/stop_master.sh
    
[ ] 2. Stop any running history server.
    
    # ps -ef|grep HistoryServer
    # kill -9 <pid>
[ ] 3. Remove junk files on each host.
    
    Login to ma2test01.        
[ ] 4. If a test run fails (i.e. step_up_multi_user.sh is canceled while running)
 
     a) Run this script:
        # /perf_test/perf_data/clean_failed_run.sh   
  
[ ] 5. Delete Terasort output folder and Spark History folder
    
    # rm -rf /mnt/nfs/SparkSessionBench/Terasort/Output/*
    # rm -rf /opt/spark/event/*
    
---------------------------------
Copy INPUT directory for Terasort
---------------------------------
[ ] 1. Copy the Terasort input ( 100 partitions)
    
    /SparkBench/Terasort/input
    
--------------------------------------
Shortcut to clean evn for a new run
--------------------------------------
    # source /opt/profile.mesos-spark-bench
    # cd /opt/mesos/mesos-0.28.2/scripts
    # ./stop_slaves.sh
    # ./stop_master.sh
    # $SPARK_HOME/sbin/stop-master.sh
    # /opt/spark/spark-1.6.1/sbin/stop-history-server.sh /opt/spark/event
    # rm -rf /mnt/nfs/SparkSessionBench/Terasort/Output/*
    # rm -rf /opt/spark/event/*
    # for i in `seq 1 6`; do echo ma2test0$i; ssh ma2test0$i rm -rf /opt/mesos/work/*; rm -rf /opt/mesos/log/*; done
    # rm -rf /var/lib/mesos/*; rm -rf /opt/mesos/mesos-0.28.2/log_dir;

-----------------------------
Shortcut to Start a new run
-----------------------------

    # source /opt/profile.mesos-spark-bench
    # cd /opt/mesos/mesos-0.28.2/scripts
    # ./start_master.sh
    # ./start_slaves.sh
    # $SPARK_HOME/sbin/start-master.sh
    # /opt/spark/spark-1.6.1/sbin/start-history-server.sh /opt/spark/event
    
    # cd /perf_test/perf_harness
    # nohup ./step_up_multi_user.sh 6 60 10 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &
    
    
    
    
    
-------------------
Result
-------------------
[ ] 1. # nohup /step_up_multi_user.sh 1 1 1 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &

    10 min
[ ] 2. # nohup /step_up_multi_user.sh 6 60 10 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &

    15hours just finish 7 jobs, total start 13 jobs
[ ] 3. # nohup /step_up_multi_user.sh 5 60 5 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &

    total 22 hours, from 12-17pm finished 15 jobs.
[ ] 4. # nohup /step_up_multi_user.sh 5 60 3 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &

    10.6 hours, completed 3 jobs, 4 running for 10.6 hours.
[ ] 5. # nohup /step_up_multi_user.sh 3 60 1 spark://9.21.55.81:7077 > /perf_test/perf_data/env_output.log 2>&1 &