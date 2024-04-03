# Instructions for Setting Up Your Personal Proxy in Virginia
  Please note! The monthly cost of running this proxy is ~$6. The proxy is running on the cheapest available server type and automatically shuts down from 11pm-11am CST daily to save on cost.  

## Prerequisites
1. Sign up for AWS: [AWS Signup](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html?refid=em_127222)

## Steps
1. **Go to the CloudFormation service in the AWS Console**
   - From the AWS Console home page, click on the "CloudFormation" service under the "Services" menu.
   ![Go to Cloudformation](./assets/1.cloudformation-navigation.png)
   - Make sure to check that you are in the us-east-1 region in the upper right-hand corner.
   ![AWS Region](./assets/us-east-1.png)

2. **Create a new stack**
   - On the CloudFormation Stacks page, click the "Create stack" button in the upper right to start creating a new stack.
   ![Create Stack](./assets/2.cloudformation-create-stack.png)

3. **Upload the simple-proxy.yaml file**
   - On the "Create stack" page, under "Prerequisite - Prepare template", select the "Upload a template file" option. 
   - Click the "Choose file" button and select the JSON or YAML formatted CloudFormation template file you want to use.
   ![Upload File](./assets/3.cloudformation-upload-file.pngg)

4. **Change your IP**
   - Choose a stack name (no special characters or spaces).
   - **Very important, change the SourceIP parameter. This value will be your IP that you are trying to mask. You can find the value at https://api.ipify.org.**
   ![Change Source IP](./assets/4.cloudformation-change-ip-param.png)

5. **Check acknowledge box and click Submit**
   ![Submit](./assets/5.cloudformation-submit.png)

6. **Wait for CloudFormation Stack to create**
   - This should take 1-2 minutes.
   ![Wait for Creation](./assets/6.cloudformation-wait-for-creation-complete.png)

7. **Navigate to the EC2 page**
   ![Navigate to EC2](./assets/7.navigate-to-ec2.png)

8. **Click on Instances**
   ![Click on Instances](./assets/8.click-on-instances.png)

9. **Click on your newly created instance (aka your proxy server)**
   ![Click on Instance](./assets/9.click-on-instance.png)

10. **Take note of the public IP address**
    - This is the IP you will use to configure the proxy on your computer/iPhone/tablet.
    ![Note IP](./assets/10.proxy-ip.png)

Remember, the most critical step is to **change the SourceIP parameter to your actual IP address** that you want to mask. You can find your IP address at https://api.ipify.org.

Using your Proxy. 

Iphone/ipad
Use Manual Proxy, enter in your Public IP from Step 10 as the "Server". Port will be 3128.
https://smartproxy.com/configuration/how-to-setup-proxy-for-iphone

Mac:
Toggle "Web proxy (HTTP)" and "Secure web proxy (HTTPS)" and enter in your Public Ip from Step 10 as the "Server". Port will be 3128.

Windows:
https://support.microsoft.com/en-us/windows/use-a-proxy-server-in-windows-03096c53-0554-4ffe-b6ab-8b1deee8dae1#:~:text=server%20connection%20manually-,Select%20the%20Start%20button%2C%20then%20select%20Settings%20%3E%20Network%20%26%20Internet,optional)%20in%20the%20respective%20boxes.


https://support.apple.com/guide/mac-help/change-proxy-settings-on-mac-mchlp2591/mac#:~:text=Learn%20how%20to%20enter%20proxy,may%20need%20to%20scroll%20down.)&text=Configure%20proxy%20server%20settings%20automatically.