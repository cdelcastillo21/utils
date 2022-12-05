import os
import sys

c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.DockerSpawner.image = os.environ['DOCKER_JUPYTER_IMAGE']
c.DockerSpawner.network_name = os.environ['DOCKER_NETWORK_NAME']
c.JupyterHub.hub_connect_ip = os.environ['HUB_IP']
c.JupyterHub.hub_ip = "0.0.0.0" # Makes accessible on local network

c.JupyterHub.admin_access = True

c.Spawner.default_url = '/lab'

notebook_dir = os.environ.get('DOCKER_NOTEBOOK_DIR') or '/home/work'
c.DockerSpawner.notebook_dir = notebook_dir
c.DockerSpawner.volumes = {'/home/carlos': '/home/work',
                           '/Volumes/DataDrive/': '/home/work/DataDrive/'}

c.LatexConfig.latex_command = 'latexmk'
