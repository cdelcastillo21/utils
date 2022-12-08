import os
import sys
from pathlib import Path

c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.DockerSpawner.image = os.environ['DOCKER_JUPYTER_IMAGE']
c.DockerSpawner.network_name = os.environ['DOCKER_NETWORK_NAME']
c.JupyterHub.hub_connect_ip = os.environ['HUB_IP']
c.JupyterHub.hub_ip = "0.0.0.0" # Makes accessible on local network

c.JupyterHub.admin_access = True

c.Spawner.default_url = '/lab'

# Set roles
# c.JupyterHub.load_roles = [
#  {
#    'description': 'Read-only user models',
#    'name': 'reader',
#    'scopes': ['read:users'],
#    'services': ['external'],
#    'users': ['maria', 'joe']
#  }
# ]

# in jupyterhub_config.py
c.JupyterHub.load_roles = [{'name': 'server-rights','description': 'Allows parties to start and stop user servers','scopes': ['servers'],'users': ['carlos'],'services': [],'groups': ['admin-group'],}]

notebook_dir = os.environ.get('DOCKER_NOTEBOOK_DIR') or '/home/jovyan'
c.DockerSpawner.notebook_dir = notebook_dir
c.DockerSpawner.volumes = {'jupyterhub-user-carlos': notebook_dir,
                           '/home/carlos': {'bind': '/home/shared'}}
# if Path('/Volumes/DataDrive/').exists():
#     c.DockerSpawner.volumes['/Volumes/DataDrive/'] = '/home/DataDrive'

c.LatexConfig.latex_command = 'latexmk'
