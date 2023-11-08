# Index
- [Setup Python Container for Development](#setup-python-container-for-development)
  * [Start the container](#start-the-container)
  * [Setup VSCode](#setup-vscode)
  * [Add or remove python packages by using pip](#add-or-remove-python-packages-by-using-pip)
  * [Add or remove python packages by using requirements file](#add-or-remove-python-packages-by-using-requirements-file)
- [Useful commands:](#useful-commands-)
  * [Start Container](#start-container)
  * [Recreate and start the container in case `Dockerfile` was modified](#recreate-and-start-the-container-in-case--dockerfile--was-modified)
  * [Stop and remove Container](#stop-and-remove-container)
  * [Remove the Image](#remove-the-image)



# Setup Python Container for Development

## Start the container
1. Define the required python packages inside `/src/requirements.txt`:

	```
	numpy
	pandas
	```
	
	(can also be updated later, see [here](#add-or-remove-python-packages-by-using-requirements-file))

2. Open Terminal inside the current directory

3. Fire up container with compose file:

	```bash
	docker compose up -d
	```	

	Hint:
	- `src` directory is automatically mounted inside the container `/app/src`
	- Required python packages are installed into the image from `/src/requirements.txt`

## Setup VSCode
1. Open VSCode

2. Install Extensions:

	- Remote Extensions
	- Dev Container

	![Remote and Dev Extensions](/docs/imgs/vscode_extensions.png)

3. Open Dev Container inside VSCode:

	![Open Dev Container](/docs/imgs/open_dev_container.png)

4. Open the working directory by hitting `F1` and type `Open Folder`, then select `/app/src`:

	![Open Folder 1](/docs/imgs/open_folder_1.png)
	![Open Folder 2](/docs/imgs/open_folder_2.png)

5. Install the Python extension inside the container:

	![Python Extension](/docs/imgs/python_extension.png)

6. Select Interpreter, press `F1` and type `Select Interpreter`, then select the main python interpreter:

	![Interpreter Selection 1](/docs/imgs/select_interpreter_1.png)
	![Interpreter Selection 2](/docs/imgs/select_interpreter_2.png)

7. Open `main.py` file from VSCode file explorer:

	![Open Main](/docs/imgs/open_main_py.png)

8. Press F5 to try start the script and select `Python File`:

	![Select launch file](/docs/imgs/select_launch_file.png)

9. At first start, VSCode tries to create a launch file. Create the `launch.json` file:

	![Create launch.json](/docs/imgs/create_launch_json.png)

10. If you wish to always execute `main.py` when pressing `F5`, open `.vscode/launch.json` and modify it:

	![Modify launch.json](/docs/imgs/modify_launch_json.png)

11. Hit again `F1` to start the `main.py` script. Finished.

## Add or remove python packages by using pip

If you want to install/remove a python package, you can use `pip` like always.

1. Open a terminal inside VSCode:

	![Open VSCode Terminal](/docs/imgs/open_terminal_vscode.png)

2. Execute the `pip` command:

	```bash
	pip install matplotlib
	```
	
	![Pip Install Package](/docs/imgs/pip_install.png)
	
3. For keeping the `requirements.txt` updated, execute now following command in the terminal:

	```bash
	pip freeze > requirements.txt
	```
	
	Hint:
	- You also need to do always this BEFORE the container is stopped, otherwise the installed packages need to be installed again.

	![Update Requirements](/docs/imgs/update_requirements.png)

4. The updated packages are now listed in `requirements.txt` and will be installed when recreating the container. 

	Hint if using git: 
	- Keep this file in the repo (do NOT list it in `.gitignore`) so that other users have the newest packages listed.
	- When other git users have updated `requirements.txt`, you need to install the new packages, follow step 5 below.

## Add or remove python packages by using requirements file
You also can list the needed packages directly in the `requirements.txt` and install them inside an existing container without container restart.

1. Update `requirements.txt` with the new package on a new line, in this case `matplotlib`. Save the file.

	```txt [requirements.txt]
	numpy
	pandas
	matplotlib
	```
	
2. Fire up a VSCode terminal and execute:

	```bash
	pip install -r requirements.txt
	```
	
	Hint if using git:
	- You also need to do this if other users have updated `requirements.txt` after a `git pull` and you do not want to stop the container. 

# Useful commands:
Open terminal outside VSCode, `cd` into the root directory for following commands:

## Start Container
```bash
docker compose up -d
```

## Recreate and start the container
This is needed in case `Dockerfile` was modified:

```bash
docker compose up -d --build
```

## Stop and remove Container
```bash
docker compose down
```

## Remove the Image
1. Stop the container (using `docker compose down`).

2. Find the image:
```bash
docker image ls -a | grep python
```
![Docker Images List](/docs/imgs/docker_image_list.png)

3. In this case, it was `pythontest-dev`. Remove the image to free up space: 
```bash
docker image rm pythontest-dev
```




