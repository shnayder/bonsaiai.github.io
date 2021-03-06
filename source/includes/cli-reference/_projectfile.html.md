# Projects and Config Files

The Bonsai command-line interface works with three files.  A `.bonsai` file in
your user directory, a project file in the directory containing the Inkling 
files and simulator configuration for a BRAIN, and a `.brains` file that links
a project file to a BRAIN in the same directory as the project file.

## .bonsai file

```ini
[DEFAULT]
port = 443
username = bonsaiuser
accesskey = 55555555-5555-5555-5555-555555555555
webport = 443
webhost = beta.bons.ai
host = api.bons.ai
usessl = True
```

The `.bonsai` file is located in your user directory. It stores your username and an access token for access to the
Bonsai servers. The `bonsai configure` CLI command will update this file and create it if it does not exist.


## .bproj file

```json
{
    "files": [
        "mybrain.ink",
        "my_simulator.py"
    ],
    "training": {
        "command": "python my_simulator.py",
        "simulator": "bonsai.python"
    }
}
```

Project files are created in the same directory as your Inkling files when
you download or create a BRAIN with the CLI. The project file has a name like
`bonsai_brain.bproj` and contains a JSON object that ties together the Inkling
files, simulator files, and simulator configuration needed to train a BRAIN.

 * `files` is a list of files to be included in this BRAIN. Directories
may also be in the `files` list. When a directory is specified, every file
within that directory is included in the BRAIN. Currently, only one inkling
file per BRAIN is supported. If `files` specifies multiple Inkling files,
only the first will be used and the remainder will be ingored.
There must be at least one valid path in the `files` list.

 * `training` is an object.  The `simulator` field of that object
points to a pre-configured simulation container inside the platform. The
`command` field describes the command to run to start the simulator.

Current list of supported simulators for Docker cloud-hosted training:

 * [`openai.gym`][1]
 * [`bonsai.python`][2]
 * [`bonsai.energyplus`][3]
 * [`bonsai.gazebo`][4]

## .brains file

```json
{
    "brains": [{
        "default": true,
        "name": "mybrain"
    }]
}

```

The `.brains` file links a project to a BRAIN on the server. You can link one
project to many BRAINs.  The file is located in the same directory as a
project file.


 * `name` is a name of one of this user's BRAINs.

 * `default` marks a named BRAIN as the default BRAIN to use with command
   operations.


[1]: https://quay.io/repository/bonsai/gym
[2]: https://quay.io/repository/bonsai/python
[3]: https://quay.io/repository/bonsai/energyplus
[4]: https://quay.io/repository/bonsai/gazebo