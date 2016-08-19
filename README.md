This script is used to get the name of the nodes allocated, specify the parameters for each job and send them to the respective node. Therefore you should run this script after allocating the nodes (either salloc ... && ./tf_launch_jobs.sh ...  or sbatch ... tf_launch_jobs.sh).

In this script it is assumed that you have two clusters of nodes: "ps" and "worker". The nodes are divided into these two categories based on the number of ps nodes you specify as parameter. This is based on the example provided by tensorflow: https://www.tensorflow.org/versions/r0.10/how_tos/distributed/index.html
Read throughout the example to understand where you would use these clusters parameters and how to set up your argument parser.

You may want to change the script parameters and clusters to fit the requirements of your network.

To see how you use it, run ./tf_launch_jobs.sh --help. In the example mentioned earlier you would do something like:
./tf_launch_jobs.sh "python trainer.py" $NUMBER_OF_NODES

If you have any questions/comments please send me an email(mwandermaassoares@lbl.gov or michelwander@computacao.ufla.br).
