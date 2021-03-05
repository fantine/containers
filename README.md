# Creating containers for scientific computing

Within the scientific community it is notoriously difficult to reuse other people's code.
Research software packages often require specific builds and dependencies that are challenging to reproduce.

Containers are standard units of software that package up centire scientific workflows, software, and libraries so that they run quickly and reliably from one computing environment to another. [Docker](https://www.docker.com]) is a standard tool for creating and deploying such software containers. 

However, Docker requires root privileges to run which makes it unsuitable for certain shared environments. Therefore, many scientific clusters use [Singularity](https://singularity.lbl.gov) instead, a more cluster-friendly version of container management.

Singularity enables users to have full control of their environment, which means you do not have to ask your cluster admin to install anything for you - you can put it in a Singularity container and run. 

## Create a Docker container 

Build a Docker container from a Dockerfile:
```
docker build -t name:tag -f docker_file .
```

- The option `-t` allows you to name and optionally a tag your container in the `name:tag` format.
- The option `-f` allows you to specify the name of the Dockerfile to use to build the container.

For instance, to recreate my machine learning (ML) framework:
```
docker build -t ml_framework:latest -f Dockerfile_ML_framework
```

Display all your Docker containers: 

```
docker image list
```

## Convert a Docker container to a Singularity container

Convert a Docker container to a Singularity container:

```
singularity build my_container.sif docker-daemon://name:tag
```

- `my_container.sif` is the name to which the Singularity container is written.
- Replace `name:tag` with the name and tag of your Docker container.
- When you use `docker-daemon;`, it looks at your locally built docker containers. Using `docker:` looks for the container on Docker Hub online (see next section). 

For instance, to convert the ML framework docker container from the previous section to a Singularity container:

```
singularity build ml_framework_latest.sif docker-daemon://ml_framework:latest
```

## Create a Singularity container straight from an Docker Hub container

Alternatively, you can also create a Singularity container straight from the Docker Hub online.

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

# Author

- Fantine Huot
