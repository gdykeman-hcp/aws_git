# Workshop Flow
## Section 1
- Demo all sections and complete up to Quiz 1 ()
- So, 5 sections to first breakpoint.
1. Exploring your workspace:
    - Basically in the first section, we are making sure we're all in the right place and have access. When following the instructions, take a look at the main.tf file and see the highlighting marked as HCL - since we are using HCL syntax the editor was able to pick it up. With that, we'll be moving on
2. Getting to know Terraform:
    - Next let's take a look at some Terraform parameters on the command line. At the shell, we'll do a terraform version - there's also a --help to guide the user with available parameters depending on where you are in the command.
3. Connecting Terraform to AWS: 
    - As for credentials, you'll see in the section - Connecting Terraform to AWS - that you'll have your access key and secret key already stored in the environment. Remember, you want to be super careful with credentials especially with accidentally uploading them into version control... This is where we want to use secure mechanims to store sensitive information such as within Terraform Cloud or Terraform Enterprise or with Hashicorp's Vault solution
4. What does TF Code look like?
    - Terraform automatically picks up all files with a .tf extension and brings it all together at execution time. 
    - Now, when it comes to variables, there's a couple things to consider
    1. variables.tf (Where your main instantiation of variables would exist - usually containing default values)
    2. Respective .tfvars that override the default values in variables.tf with the values you want for the respective plan/apply
    3. .auto.tfvars extension which will automatically be included as part of the execution. We can dive into this in a bit more detail later but it's a way to tell Terraform to bring in varibles files with custom naming schemes
5. Terraform Init - Install the providers
    - So in your main.tf you'll find at the top a "providers" section. Terraform works off the concept of providers which "provides" Terraform with, say the necessary libraries or modules so that you can execute your Terraform code. So if I want to use AWS resources or content, I would need the aws provider to do so. Same for Azure, GCP, VMware, etc.
    - We're going to go ahead and execute a terraform init here which initializes Terraform and gathers / downloads providers that are needed which in turn means all the necessary modules, resources, content so that we can execute our terraform code
    - You can take a look at the available providers after the init by taking a  look at the .terraform directory
6. Quiz 1 - Providers and Modules

## Section 2
1. Terraform Validate:
    - You can use the following command to have Terraform validate your syntax
    - Very useful during development but also for automated pipelines, to ensure that the code has the correct syntax to catch errors before deploying
2. Terraform Plan
    - So next, terraform plan. Now in your case, you're going to enter in a prefix as it was written in a way to prompt the user at execution time to define. Usually, you would have this information defined in the variable file related to your deployment so everything would be automated which you'll see in the following exercise as you go through the lab.
    - Terraform plan provides you with information regarding the infrastructure if the code were to be executed what would change, as in be added, deleted, unchanged, etc.
3. Working with Terraform Variables
    - So as discussed previously, there's your variables.tf which is a good place to instaniate variables with default values
    - Then usually you would have a terraform.tfvars the populates those variables with the specific values necessary for the current deployment
    - You'll be editing the terraform.tfvars file to specify the prefix and no longer require prompting of the user
4. Change your location
    - Nothing more to mention, students will edit another variable
5. Quiz 2 - Variables

## Section 3
1. Terraform Graph:
    - Want to touch on terraform graph
        - terrafrom graph generates a dependecy graph that can be used to visualize the dependencies within your terraform deployment
    - Let me show you that here:
        - terraform graph: which generates this data. But this data can be ingested by other tools, in our case, something called blast radius
        - blast-radius --serve --port 8888 .
        - Good for not only documentation of your infrastructure but to understand the relationships between resources and evalute how changes would affect them
2. Terraform plan and terraform apply
    - Let's go back to terraform plan. This showed us what would change (if any) if the terraform code were actually executed (or applied)
    - Now, terraform apply by default runs a plan first then prompts the user for a confirmation "yes" to actually apply the plan. You can set a flag for auto approve but that is what terraform apply is doing
3. Test and Repair
    - Terraform is idempotent as in, it won't make changes if its not required. Different from most scripting that is written where you blindly push out the changes regardless - usually resulting in overrwriting values that may already exist with the same value
4. Change your prefix (changing a var and seeing the diff in plan/apply)
5. Tagging
    - Tagging is usually a good idea and in a lot of cases a requirement for organizations. Not only does it specify who the resource belongs too but also helps with more fine grained control of what is deployed and how its deployed
6. Continue with labs
7. Quiz 3 - Terraform Apply

## Section 4
1. Use a provisioner:
    - You'll be working with a section known as "remote-exec" there's also a "local-exec" for commands or scripts that should be executed locally.
    - What this allows for is post provisoning steps. In the lab, you'll execute a command in cowsay but you'll get the idea of its use. Install packages, invoke scripts, execute commands, etc. Things you would want to perform post provisioning
2. Variable precedence:
    - So, since there are a number of ways to bring in variables, Terraform loads variables in a specific order, with later sources taking precedence over earlier ones. Meaning, Terraform uses the last value it finds, overriding any previous values.
    - Environment Variables
    - terraform.tfvars if present
    - terraform.tfvars.json if present
    - .auto.tfvars // .auto.tfvars.json
    - -var or a -var-file switch at the cli
3. Do the exercises
4. Quiz 4

## Section 5
1. Terraform Cloud
    - Lastly you'll be running through terraform cloud setup and usage
2. Configuring remote state
3. Workspace connection methods
4. and finally terraform destroy