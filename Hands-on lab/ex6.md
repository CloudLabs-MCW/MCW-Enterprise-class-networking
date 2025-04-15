## Exercise 6: Provision and configure Azure firewall solution

In this exercise, you will provision and configure an Azure firewall in your network.

## Lab objectives

In this lab, you will perform following tasks:

- Provision the Azure firewall
- Create Firewall Rules
    
## Estimated timing: 60 minutes

### Task 1: Provision the Azure firewall

1. In the search bar of the Azure portal, type **Firewall (1)**. From the search results, select **Firewalls (2)**.

    ![](images/lab6fire1.png)

1. Click on **+ Create**.

1. On the **Create a firewall** blade, on the **Basics** tab, enter the following information:

    | Setting | Action |
    | -- | -- |
    | Subscription | Select your subscription **(1)** |
    | Resource group | **WGVNetRG1** **(2)** |
    | Name | **azureFirewall** **(3)** |
    | Region | **South Central US** **(4)**|
    | Firewall SKU | **Standard** **(5)** |
    | Firewall management | **Use Firewall rules (classic) to manage this Firewall** **(6)** |
    | Choose a Virtual network | **Use existing** **(7)** |

    ![](images/lab6fire1b.png)

1. Select **Virtual Network** as **WGVNet1 (1)**, click **Add new (2)** for **Public IP address**, name it **azureFirewall-ip (3)**, and click **OK (4)**.

    ![](images/lab6fire1c.png)

    >**Note:** If you receive the message **"Force Tunneling requires this virtual network to have a subnet named AzureFirewallManagementSubnet"**, it will disappear once you uncheck the **Enable Firewall Management NIC**.

    ![](images/lab6fire1a.png)

1. Uncheck the box for the **Enable Firewall Management NIC** then click on **Next:Tags>**.

    ![](images/lab6fire1d.png)

     >**Note:** Add the **Public ip address** again, if it disappers. Please refer 4th step.

1. Select Select **Review + create** and then select **Create** to provision the Azure Firewall.

    >**Note**: It will take **5-7 minutes** to be created.

1. Perform the below validation after completing **Task 2**.    

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="7fb0feba-84e2-4b2f-a525-8804ed2e92f1" />


### Task 2: Create Firewall Rules

We will create firewall rules to allow the inbound and outbound traffic.

1. On the main Azure menu, select **Resource groups**.

2. Select the **WGVNetRG1 (1)** resource group. This resource group contains the **azure firewall and its public IP address** resources **(2)**.

    ![](images/e8.png)

3. Navigate to the **azureFirewall-ip** blade and note the value of its **public IP address**. You will need it later in this task.

    ![](images/e9.png)

4. Navigate to the **azureFirewall** blade, and, on the **Overview** page, select **Rules (classic) (1)** under **Settings** on the left and select **+ Add NAT Rule collection (2)**

    ![](images/e10.png)

5. Enter the following information to create an inbound NAT Rule (a collection is a list of rules that share the same priority and action).

    | Setting | Action |
    | -- | -- |
    | Name | **NATRuleCollection1** |
    | Priority | **250** |
    | Rules name | **IncomingHTTP** |
    | Protocol | **TCP** |
    | Source type | **IP Address** |
    | Source| **\*** |
    | Destination Address | Type the **public IP address** assigned to the firewall you identified earlier in this task|
    | Destination ports | **80** (to allow HTTP traffic) |
    | Translated Address | **10.8.0.100** (Private IP of the Azure Load Balancer you deployed earlier in this lab.) |
    | Translated Port | Translated Port: **80** |

    ![](images/e12.png)
    ![](images/e13.png)

6. Add another rule for HTTPS, as illustrated in the following screenshot. The rules should look like the image below.

    | Setting | Action |
    | -- | -- |
    | Rules name | **IncomingHTTPS** |
    | Protocol | **TCP** |
    | Source type | **IP Address** |
    | Source | **\*** |
    | Destination Address | Type the public IP address assigned to the firewall you identified earlier in this task. |
    | Destination ports | **443** |
    | Translated Address | **10.8.0.100** |
    | Translated Port | **443** |
  
    ![](images/e-11.png)

7. Select **Add** and wait until the update completes.

8. Back on the Azure Firewall **Rules (classic)** page, select **Network rule collection (1)**. Then Select **+ Add Network Rule collection (2)**. 

    ![In this screenshot, the azureFirewall Rules (classic) blade is depicted. The 'Network rule collection' tab and the 'Add network rule collection' link are highlighted.](images/hol-ex6-task2-network-rule-collection.png)

1. Enter the following information to create a Network Rule for inbound traffic. This rule allows HTTP connectivity from any directly connected network targeting the frontend IP address of the load balancer.

    | Setting | Action |
    | -- | -- |
    | Name | **NetworkRuleCollectionAllow1** |
    | Priority | **100** |
    | Action | **Allow** |
    | Rules name (IP Addresses) | **IncomingWeb** |
    | Protocol | **TCP** |
    | Source| **\*** |
    | Destination Address | **10.8.0.100** |
    | Destination ports | **80,443** |

    ![](images/lab6fire8.png)

9. Create another rule for Remote Desktop sessions from the Management subnet on WGVNet1. The IP Addresses rules should look like the image below.

    | Setting | Action |
    | -- | -- |
    | Rules name (IP Addresses) | **IncomingMgmtRDP** |
    | Protocol | **TCP** |
    | Source| **10.7.2.0/25** |
    | Destination Address | **10.8.0.0/25** |
    | Destination ports | **3389** |

    ![In this screenshot, the 'IP Addresses' section of the 'Add network rule collection' blade of the Azure portal is depicted with the required settings listed above selected.](images/e14.png "Azure Firewall IP Addresses section")

10. Select **Add** and wait for 5-7 minutes until the update completes.

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="460b4d7d-dd41-4dcc-822b-d7978c970f3f" />

### Review
In this lab, you have completed:
- Provisioned the Azure firewall
- Created Firewall Rules

## Great job on completing this exercise! You can now proceed to the next one.
