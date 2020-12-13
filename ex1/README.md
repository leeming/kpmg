# Challenge #1

A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.


# Solution
3-tier solution using terraform at the infrastructure only level provided. 
- I have not gone into details of networking a real application together.
- AMIs could be prebuilt using packer or other techniques.
- Basic security group and default subnets used
- Ideally DNS and db connection details should be recorded somewhere (e.g. SSM with KMS, or secrets manager)
- Terraform modules can be used in future refactoring iterations as frontend and backend were mostly repeated.
	- Howerver, organisational modules (or trusted 3rd party) should be used in preference to hand rolled ones per project
- Both LB DNS records are shown as output to test ASGs are working correctly
