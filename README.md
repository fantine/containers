## Convert a Docker container to a Singularity container

`docker build -t local/my_container .`

`sudo singularity build my_container.sif docker-daemon://local/my_container`

Using `docker://my_container` looks for the container on Docker Hub. 
When you use docker-daemon, it looks at your locally built docker containers. 

## Create a Singularity container straight from an Docker Hub container

Create a Singularity container with the latest version of TensorFlow GPU:

`singularity build tensorflow_latest.sif docker://tensorflow/tensorflow:latest-gpu`

Create a Singularity container with a specific version of TensorFlow (in this case, the GPU version 2.2.2):

`singularity build tensorflow_2.2.2.sif docker://tensorflow/tensorflow:2.2.2-gpu`

## Running a Singularity container

Runs an interative shell session on GPUs (`--nv`) loading the container image `tensorflow.sif`.

`singularity exec --nv tensorflow.sif bash`

## Running a GPU job on Mazama

Log into CEES Mazama's headnode:

`ssh cees-mazama.stanford.edu`

Do not run your jobs directly on the headnode. Instead, submit Slurm job requests from the headnode. 

Use this command to request to run an interative bash session on the GPU partition using 1 GPU:

`srun --partition=gpu --gres=gpu:1 --pty bash`
