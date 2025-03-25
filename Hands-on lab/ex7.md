## Exercise 7: Configure Site-to-Site connectivity

In this exercise, we will simulate an on-premises connection to the internal web application. To do this, we will first set up another Virtual Network in a separate Azure region followed by the Site-to-Site connection of the 2 Virtual Networks Finally, we will set up a virtual machine in the new Virtual Network to simulate on-premises connectivity to the internal load-balancer.

## Lab objectives

In this lab, you will perform following tasks:

- Create OnPrem Virtual Network
- Configure gateway subnets for on premise Virtual Network
- Create the first gateway
- Create the second gateway
- Connect the gateways
  
## Estimated timing: 60 minutes

### Task 1: Create OnPrem Virtual Network

1. In the search bar of the Azure portal, type **Virtual network (1)**. From the search results, select **Virtual network (2)**.

    ![](images/lab1vnet2.png)

1. Click on **Create**.

2. On the **Create virtual network** blade, enter the following information and then click on **IP addresses (5)** tab.

    | Setting | Action |
    | -- | -- |
    | Subscription | Select your subscription **(1)** |
    | Resource group | Select **OnPremVNetRG (2)** |
    | Name | **OnPremVNet (3)** |
    | Region | **East US (4)** (Make sure this is **NOT** the same location you have specified in the previous exercises.) |

    ![](images/e17.png)

3. Now click on the **IP addresses** tab of the **Create virtual network blade**, enter the following information.

4. Edit the IP address space as **192.168.0.0  (1)** and the subnetting with **/16  (2)**.

    ![](images/lab7vnet2-updated1.png)

4. Select **Review + create (3)** then **Create**.

5. Click on **Go to resources.**

### Task 2: Configure gateway subnets for on premise Virtual Network

1. On the **OnPremVNet** blade and select **Subnets** and then select **+ Subnet**.

    ![](images/lab7vnet3.png)

1. Specify the following configuration for the subnet, and select **Add (4)**:

    | Setting | Action |
    | -- | -- |
    | Subnet Purpose | **Virtual Network Gateway (1)** |
    | Starting address | **192.168.1.0 (2)** |
    | Size | **/27 (32 addresses) (3)** |

    ![](images/e18.png)

1. Next, select **+ Subnet** and add the **OnPremManagementSubnet** subnet to the **OnPremVNet**, as shown below in the screenshot:

    - Name: **OnPremManagementSubnet**

    - Address range: **192.168.2.0/27**

    - Leave the rest of the values as their defaults. Select **Add**.

        ![](images/lab7vnet4a.png)

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="e84eca2b-bc7c-4fa9-ac22-eeccd0d75de2" />

### Task 3: Create the first gateway

1. In the search bar of the Azure portal, type **Virtual network gateway (1)**. From the search results, select **Virtual network gateway (2)**.

    ![](images/lab7vnet5.png)

1. Click on **+Create**.    

1. On the **Create virtual network gateway** blade,  enter the following information and select **Review + create**:

    | Setting | Action |
    | -- | -- |
    | Subscription | **Select your subscription** |
    | Name | **OnPremWGGateway** |
    | Region | **East US** (This must match the location in which you created the **OnPremVNet** virtual network.) |
    | Gateway type | **VPN** |
    | SKU | **VpnGw1** |
    | Generation | **Generation1** |
    | Virtual network | **OnPremVNet** |
    | Public IP address | **Create new** |
    | Public IP address name | **onpremgatewayIP1** |
    | Enable active-active mode | **Enabled** |
    | Second Public IP address name | **onpremgatewayIP2** |
    | Configure BGP | **Disabled** |

    ![](images/lab7vnet6.png)
    ![](images/lab7vnet7.png)

1. Validate your settings and select **Review + Create** then **Create**.

    >**Note:** The gateway will take 30-45 minutes to provision. Rather than waiting, continue to the next task.

### Task 4: Create the second gateway

1. In the search bar of the Azure portal, type **Virtual network gateway (1)**. From the search results, select **Virtual network gateway (2)**.

    ![](images/lab7vnet5.png)

1. Click on **+ Create**.    

1. On the **Create virtual network gateway** blade,  enter the following information and select **Review + create**:

    | Setting | Action |
    | -- | -- |
    | Subscription | **Select your subscription** |
    | Name | **WGVNet1Gateway** |
    | Region | **South Central US** (This must match the location in which you created the **WGVNet1** virtual network.) |
    | Gateway type | **VPN** |
    | SKU | **VpnGw1** |
    | Generation | **Generation1** |
    | Virtual network | **WGVNet1** |
    | Public IP address | **Create new** |
    | Public IP address name | **vnet1gatewayIP1** |
    | Enable active-active mode | **Enabled** |
    | Second Public IP address name | **vnet1gatewayIP2** |
    | Configure BGP | **Disabled** |

    ![](images/lab7vnet8.png)
    ![](images/lab7vnet9.png)

1. Validate your settings and select **Review + Create** then **Create**.

    >**Note:** The gateway will take 30-45 minutes to provision. You will need to wait until both gateways are provisioned before proceeding to the next section.

1. The Azure portal will display a notification when the deployments have completed.

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="f6220584-0bee-4752-9cde-a4f42292dc10" />

### Task 5: Connect the gateways

1. In the Azure portal, in the 'Search resources, services, and docs' search box, type **connections** in the search text box. Select **Connections**.

    ![](images/lab7vnet9b.png)

2. Click on **Create**.

2. On the **Connection** blade, select **Create**.

3. On the **Basics** blade, leave the **Connection type** set to **VNet-to-VNet**. Select the existing **WGVNetRG1** resource group. Enter the following information and select **Next: Settings**:
    - Establish bidirectional connectivity - checked
    - First connection name - **WGVNet1-to-OnPremWGGateway**
    - Second connection name - **WGGateway-to-WGVNet1**
    - Region - **South Central US**

        ![](images/hol-ex7-task5-create-connection-vnet-to-vnet.png)

4. On the Settings step, select **WGVNet1Gateway** as the first virtual network gateway and **OnPremWGGateway** as the second virtual network gateway. Ensure **Establish bidirectional connectivity** and **IKEv2** is selected. Enter a shared key, such as **A1B2C3D4**. Select **Review + create**.

    ![](images/lab7vnet9a.png)

5. Select **Create** on the **Summary** page to create the connection.

6. In the Azure portal, in the 'Search resources, services, and docs' search box, type **connections** in the search text box. Select **Connections**.

    ![](images/lab7vnet9b.png)

7. Watch the progress of the connection status, and use the **Refresh** icon until the status changes for both connections from **Unknown** to **Connected**. This may take 5-10 minutes or more. You might need to refresh the page to see the change in status.

    ![](images/hol-ex7-task5-connections-blade.png)

### Review

In this lab, you have completed:
- Created OnPrem Virtual Network
- Configured gateway subnets for on premise Virtual Network
- Created the first gateway
- Created the second gateway
- Connected the gateways

## Great job on completing this exercise! You can now proceed to the next one.
