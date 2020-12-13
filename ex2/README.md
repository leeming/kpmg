# Challenge #2

Summary

We need to write code that will query the meta data of an instance within aws and provide a json formatted output. The choice of language and implementation is up to you.
 
Bonus Points

The code allows for a particular data key to be retrieved individually

## Solution 
Run `./query_metadata.sh` on ec2 (or any cloud image that supports cloudinit) to display the instance metadata formatted as JSON.

To show only a specific key, provide it as an argument. e.g. `./query_metadata.sh hostname`. Due to the way keys are filtered, if you
want to query a key that has a hyphen ('-') in it, you will need to double quote the key. e.g. `./query_metadata.sh '"public-keys"'`. 
Note: JQ needs to be installed if using this capability.
