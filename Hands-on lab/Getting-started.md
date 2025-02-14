# Enterprise-Class Networking in Azure

### Overall Estimated Duration: 8 hours

## Overview

In this hands-on lab, you will setup and configure virtual networks in a secure hub-and-spoke design. You will also learn how to secure virtual networks by implementing Azure Firewall, network security groups and application security groups, as well as configure route tables on the subnets in your virtual network. Additionally, you will set up access to the virtual network via a jump box and provision a site-to-site VPN connection from another virtual network, providing emulation of hybrid connectivity from an on-premises environment.

## Objective

You have been asked by Woodgrove Financial Services to provision a proof of concept deployment that will be used by the Woodgrove team to gain familiarity with a complex Virtual Networking deployment, including all of the components that enable the solution. Specifically, the Woodgrove team will be learning:

- How to bypass system routing to accomplish custom routing scenarios.

- How to capitalize on load balancers to distribute load and ensure service availability.

- How to implement Azure Firewall to control hybrid and cross-virtual network traffic flow based on policies.

- How to implement a combination of Network Security Groups (NSGs) and Application Security Groups (ASGs) to control traffic flow within virtual networks.

- How to monitor network traffic for proper route configuration and trouble shooting.
  
## Pre-requisites

Participants should have the following prerequisites

- **Basic Knowledge of Docker**: Familiarity with containerization concepts and Docker, including building and running Docker images.
- **Experience with Azure Container Apps**: Understanding of Azure Container Apps and the process of deploying containerized applications on Azure.
- **Familiarity with REST APIs**: Basic knowledge of REST API concepts for interacting with the Recommendation service and verifying functionality.
- **Basic Programming Skills**: Proficiency in Python or a similar programming language to work with the Recommendation service and containerization scripts.
- **Development Environment Setup**: Ability to set up a local development environment for running the Miyagi frontend and building Docker images.

## Architecture

The architecture involves the implementation of a hub-and-spoke network topology in Azure to facilitate secure, scalable, and efficient enterprise-class networking. The hub serves as a central point for connectivity and management, hosting shared services such as Azure Firewall, VPN gateways, and Azure Bastion for secure remote access. The spokes are individual VNets that isolate workloads, applications, or business units while connecting to the hub via VNet peering. Traffic flow is controlled through Azure Route Tables, ensuring optimized communication between resources. Azure Firewall or Network Virtual Appliances (NVAs) provide perimeter security, while hybrid connectivity with on-premises environments is achieved using Azure ExpressRoute or VPN Gateway, creating a robust and manageable cloud network infrastructure.

## Architecture Diagram

   ![This image represents an entire overview of an environment for the result of this proof of concept. On the left is the OnPremVNetRG resource group, in the middle is the WGVNetRG1 resource group, and on the right is the WGVNetRG2 resource group. In the lower right is the MonitoringRG resource group.](images/hol-architectures-01.png "Solution Architecture")

## Explanation of Components

The architecture for this lab involves several key components:  

- **Networking Components:** Virtual Networks (OnPremVNet, WGVNet1, WGVNet2), Azure BastionSubnet, and secure connectivity between on-premises and Azure.  
- **Security and Access:** Azure Firewall for traffic filtering and Azure Bastion for secure VM access.  
- **Compute Resources:** OnPremVM, WGWEB1, WGWEB2 for application workloads, and WGSQL1 for database services.  
- **Load Balancer:** Distributes incoming traffic across application servers for high availability.  
- **Subnets:** AppSubnet for application workloads and DataSubnet for database operations.  
- **Monitoring and Management:** MonitoringRG for centralized performance monitoring and logging.  
- **Hybrid Connectivity:** Integration of on-premises infrastructure with Azure cloud via secure connectivity.

# Getting Started with the Lab

1. After the environment has been set up, your browser will load a virtual machine (JumpVM), use this virtual machine throughout the workshop to perform the lab. You can see the number on the bottom of the lab guide to switch to different exercises in the lab guide.

   ![](images/gettingstartedpagenew1-v2.png)
 
1. To get the lab environment details, you can select the **Environment** tab. Additionally, the credentials will also be emailed to your registered email address. You can also open the Lab Guide in a separate and full window by selecting the **Split Window** from the lower right corner. Also, you can start, stop, and restart virtual machines from the **Resources** tab.

    ![](images/gettingstartedpagenew2-v2.png)
   
   > You will see the SUFFIX value on the **Environment** tab; use it wherever you see SUFFIX or DeploymentID in lab steps.

## Lab Guide Zoom In/Zoom Out
 
To adjust the zoom level for the environment page, click the **A↕ : 100%** icon located next to the timer in the lab environment.

![](images/n21.png)
 
## Login to the Azure Portal

1. In the JumpVM, click on the Azure portal shortcut of the Microsoft Edge browser, which is created on the desktop.

   ![](images/gettingstartpage3.png)

1. On the **Sign in to Microsoft Azure** tab, you will see the login screen. Enter the following email or username, and click on **Next**. 

   * **Email/Username**: **<inject key="AzureAdUserEmail"></inject>**

     ![](images/miyagi-image2.png)
     
1. Now enter the following password and click on **Sign in**.
   
   * **Password**: **<inject key="AzureAdUserPassword"></inject>**

     ![](images/miyagi-image3.png)
   
1. If you see the pop-up **Stay Signed in?**, select **No**.

   ![](images/miyagi-image4.png)

1. If a **Welcome to Microsoft Azure** popup window appears, select **Cancel** to skip the tour.

    ![](images/miyagi-image5.png)

 > [!IMPORTANT]<br>
 > **For a smoother experience during the hands-on lab, it's important to thoroughly review both the instructions and the accompanying notes. This will help you navigate through the tasks with ease and confidence.**

## Support Contact

The CloudLabs support team is available 24/7, 365 days a year, via email and live chat to ensure seamless assistance at any time. We offer dedicated support channels tailored specifically for both learners and instructors, ensuring that all your needs are promptly and efficiently addressed.

Learner Support Contacts:

- Email Support: cloudlabs-support@spektrasystems.com.
- Live Chat Support: https://cloudlabs.ai/labs-support

Now, click on Next from the lower right corner to move on to the next page.

![](images/n8.png)

## Happy Learning!!