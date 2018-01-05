from flask import Flask

import docker
import json

app = Flask(__name__)


@app.route('/')

def IndexPage():
	client = docker.from_env()

	container ={}
	images = {}
	volume = {}
	network = {}

	for container in client.containers.list():

		print container.id

	for image in client.images.list():

		print image.id

	for volume in client.volumes.list():

		print volume.id

	for network in client.networks.list():

		print network.id

	data = {
		'container': container.id, 
		'image': image.id, 
		'volumes': volume.id, 
		'networks': network.id
	}

	output = json.dumps(data)
	
	return output

if __name__ == '__main__':

	app.run(host='0.0.0.0')