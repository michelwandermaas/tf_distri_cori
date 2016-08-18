The tf_launch_job.sh script assumes your network is similar to that of https://www.tensorflow.org/versions/r0.10/how_tos/distributed/index.html.

It is also assumed that you have already allocated the nodes you are going to use, using "salloc -N NUMBER_OF_NODES ...".

All the script does is figure the nodes names, arrange them based on the number of ps nodes and worker nodes (as in the example mentioned earlier) and launches the jobs on each node with the appropriate arguments.

To see how you use it, run ./tf_launch_job.sh --help.

If you have any questions/comments please send me an email(mwandermaassoares@lbl.gov).
