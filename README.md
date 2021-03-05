Learn more about Singularity containers: https://singularity.lbl.gov

## Convert a Docker container to a Singularity container

Build your container with Docker. 

`docker build -t my_container .`

If you run `sudo docker image list` you will see a list of your docker containers.
It will show repositories and tags for all of them.
Use the following command to create a Singularity container from your Docker container. 
Replace `my_container` and `latest` with the repository and tag of your choice.

`sudo singularity build my_container.sif docker-daemon://my_container:latest`

Using `docker://my_container` looks for the container on Docker Hub. 
When you use docker-daemon, it looks at your locally built docker containers. 

## Create a Singularity container straight from an Docker Hub container

Create a Singularity container with the latest version of TensorFlow GPU:

`singularity build tensorflow_latest.sif docker://tensorflow/tensorflow:latest-gpu`

Create a Singularity container with a specific version of TensorFlow (in this case, the GPU version 2.2.2):

`singularity build tensorflow_2.2.2.sif docker://tensorflow/tensorflow:2.2.2-gpu`

## Running a Singularity container

Runs an interative shell session on GPUs (`--nv`) loading the container image `tensorflow.sif`.

`singularity shell --nv tensorflow.sif`

## Bind volumes

If enabled by the system administrator, Singularity allows you to map directories on your host system to directories within your container using bind mounts. This allows you to read and write data on the host system with ease. More info here: https://singularity.lbl.gov/docs-mount

`singularity shell --nv -B /scr1/fantine:/scr1/fantine tensorflow_2.2.2.sif`

You can also set it as an environment variable.  

`export SINGULARITY_BINDPATH="/opt,/data:/mnt"`

## Running a GPU job on Mazama

Log into CEES Mazama's headnode:

`ssh cees-mazama.stanford.edu`

Do not run your jobs directly on the headnode. Instead, submit Slurm job requests from the headnode. 

Use this command to request to run an interative bash session on the GPU partition using 1 GPU:

`srun --partition=gpu --gres=gpu:1 --pty bash`
