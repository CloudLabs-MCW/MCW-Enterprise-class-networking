## Exercise 8: Validate connectivity from 'on-premises' to Azure

In this exercise, you will validate connectivity from your simulated on-premises environment to Azure using multiple scenarios.

## Lab objectives

In this lab, you will perform the following tasks:

- Create a virtual machine to validate connectivity
- Configure routing for simulated 'on-premises' to Azure traffic
  
## Estimated timing: 60 minutes

### Task 1: Create a virtual machine to validate connectivity

1. Create a new virtual machine in the OnPremVNet virtual network. In the Azure portal, search for **Virtual machines (1)** and select **Virtual machines (2)**.

    ![](images/e1.png)

1. Click on **+ Create (1)** drop down amd select **Azure Virtual Machine (2)**.

    ![](images/e28.png)

1. On the **Create a virtual machine** blade, on the **Basics** tab, enter the following information, and select **Next : Disks >**:

    | Setting | Action |
    | -- | -- |
    | Subscription | **Select your subscription** **(1)** |
    | Resource group | Select **OnPremVMRG** **(2)** |
    | Virtual machine name | **OnPremVM** **(3)** |
    | Region | **(US) East US** **(4)** (This must match the region in which you created the OnPremVNet virtual network.) |
    | Availability options | **No infrastructure redundancy required** **(5)** |
    | Image | **Windows Server 2019 Datacenter - Gen2** **(6)** |
    | Size | **Standard DS1 v2** **(7)** |
    | User name | **demouser** **(8)** |
    | Password/Confirm password | **demo\@pass123** **(9)** |
    | Public inbound ports | **Allow selected ports** **(10)** |
    | Select inbound ports | **RDP** **(11)** |

    ![](images/lab8vm1.png)

    ![](images/lab8vm2.png)
   
    ![](images/lab8vm3.png)

1. Click on **Next: Disk >**, then proceed to the networking section by clicking on **Next: Networking >**.

1. On the **Create a virtual machine** blade, on the **Networking** tab, set the following configuration:

    | Setting | Action |
    | -- | -- |
    | Virtual network | **OnPremVNet** **(1)** |
    | Subnet | **OnPremManagementSubnet (192.168.2.0/27)** **(2)**|
    | Public IP | **(new) OnPremVM-ip** **(3)** |
    | NIC network security group | **Basic** **(4)** |
    | Public inbound ports | **Allow selected ports** **(5)** |
    | Select inbound ports | **RDP** **(6)** |
    | Enable Accelerated networking | **Unchecked** **(7)** |
    | Load balancing options | **None** **(8)** |

    ![](images/lab8vm4.png)

1. On the **Create a virtual machine** blade, click on **Review+create (9)**.
   
    ![](images/vmcreate.png)

1. Ensure the validation passes, and select **Create**. The virtual machine will take about 5 minutes to provision.

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="1c761e87-33d3-4520-b0d8-9f9e36ffc395" />

### Task 2: Configure routing for simulated 'on-premises' to Azure traffic

When packets arrive from the simulated 'on-premises' Virtual Network (OnPremVNet) to the 'Azure-side' (WGVNet1), they arrive at the gateway WGVNet1Gateway. This gateway is in a gateway subnet (10.7.15.0/27). For packets to be directed to the Azure firewall, we need another route table and route to be associated with the gateway subnet on the 'Azure-side'.

1. In the search bar of the Azure portal, type **Route tables (1)**. From the search results, select **Route tables (2)**.

    ![](images/lab4route1.png)

2. On the **Route tables** blade, select **+ Create**.

3. On the **Create route table** blade, enter the following information:

    - Subscription: **Select your subscription (1)**.

    - Resource group: Select the drop-down menu, and select **WGVNetRG1 (2)**.

    - Region: **South Central US (3)** (This must match the location in which you created the **WGVNet1** virtual network.)

      > **Note**: Ensure this is created in the **WGVNet1** virtual network.

    - Name: **WGAzureVNetGWRT (4)**

    - Propagate gateway routes: **Yes (5)**

    - Select **Review + create (6)**

        ![](images/e29.png)

4. Then **Create**.

5. Select **Go to resource** to go to the **WGAzureVNetGWRT** route table.

6. Select **Routes (1)** under **Settings** on the left.On the **Routes** blade, select the **+ Add (2)** button. 

   ![](images/e30.png)

7. Enter the following information, and select **Add (6)**:

    | Setting | Action |
    | -- | -- |
    | Route name | **OnPremToAppSubnet (1)** |
    | Destination type | **IP Addresses (2)** |
    | Destination IP addresses/CIDR ranges | **10.8.0.0/25 (3)** |
    | Next hop type | **Virtual appliance (4)** |
    | Next hop address | **10.7.1.4 (5)** |

    ![](images/e31.png)

8. In the search bar of the Azure portal, type **Virtual network (1)**. From the search results, select **Virtual network (2)**.

   ![](images/lab1vnet2.png)

9. Select the **WGVNet1** virtual network.

10. Under the **Settings (1)** section, select **Subnets (2)**. On the **Subnets** blade, select **Gateway Subnet (3)**.

    ![](images/lab8vm6.png)

11. On the **GatewaySubnet** dialog, under the **Route table** drop down, select **WGAzureVNetGWRT (1)**. Then select **Save (2)**.

    ![](images/e32.png)

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="0a679517-f88e-4564-b23c-a4c72b763c6b" />

>**Note:** At this point, you have configured your enterprise network. You should be able to test your Enterprise Class Network from one region to another. Your testing can include the following scenarios:

### Scenario 1: Verifying RDP Access Restriction by Azure Firewall

In this scenario, you will initiate a Remote Desktop (RDP) session from the **OnPremVM** virtual machine to a virtual machine in the **AppSubnet (10.8.0.0/25)**. However, the connection should fail due to Azure Firewall restrictions. Please follow the below steps:

1. On the Azure portal, type **Virtual Machines (1)** in the search box and select **Virtual Machines (2)** from the results.

    ![](images/02032025(9).png)

1. On the **Virtual Machines** page, find and select **OnPremVM**.

    ![](images/02032025(10).png)

1. Click **Connect (1)** and choose **Connect (2)** as the connection method.

    ![](images/02032025(11).png)

1. Under the **Native RDP** option, click **Download RDP file**.

    ![](images/02032025(12).png)

1. If you recieve any pop up, click on **Keep**.

    ![](images/e33.png)

1. Select **Open file**.

    ![](images/e34.png)

1. Open the downloaded RDP file and click **Connect**.

    ![](images/02032025(13).png)

1. Click on **More choices**.

    ![](images/e35.png)

1. Click on **Use a different account**.

    ![](images/e36.png)

1. When prompted, enter the following credentials and click **OK (3)**:  
   
   - **Username (1):** `.\demouser`  

   - **Password (2):** `demo@pass123`

     ![](images/e37.png)

1. Click **Yes** on the security pop-up to proceed.

    ![](images/02032025(15).png)

1. Inside **OnPremVM**, search for **Remote Desktop Connection (2)** in the Windows **search bar (1)** and open the **Remote Desktop Connection (3)** application. 

    ![](images/02032025(16).png)

1. In the **Computer** field, enter **10.8.0.5** and click **Connect**.

    ![](images/02032025(18).png)

1. The connection attempt should fail, displaying the error message: **Remote desktop can't be connected to the remote computer**.

1. Click **OK** to close the error message.

    ![](images/02032025(19).png)

This confirms that RDP access to the AppSubnet is blocked by Azure Firewall.

### Scenario 2: Accessing the Web Application via Bastion in WGWEB1 or WGWEB2 VM

In this scenario, you will access the web application deployed in **WGVNet2** using the private IP address of the **Azure Load Balancer (10.8.0.100)**. This will be done from within **WGWEB1** or **WGWEB2** after establishing a Bastion session. Since the traffic is routed through **Azure Firewall**, access should be successful. 

1. On the Azure portal, type **Virtual Machines (1)** in the search box and select **Virtual Machines (2)** from the results.

    ![](images/02032025(9).png)

3. On the **Virtual Machines** page, find and select **WGWEB1**.

    ![](images/02032025(20).png)

4. Click **Connect (1)** and choose **Connect via Bastion (2)** as the connection method.

    ![](images/02032025(21).png)

7. Enter the following credentials and click **Connect (3)**:

   - **Username (1):** `demouser`

   - **VM Password (2):** `demo@pass123`

     ![](images/02032025(22).png)

1. On the desktop, open **Microsoft Edge**, enter **10.8.0.100** (the private IP of the Azure Load Balancer) in the address bar, and press **Enter** to load the web application.

    ![](images/02032025(23).png)

1. The web page should open successfully, confirming that traffic is routed correctly through **Azure Firewall**.

1. Close the RDP session.

Please follow the same steps for **WGWEB2**.

### Scenario 3: Initiating an RDP Session to WGSQL1 from WGWEB1 via Bastion  

In this scenario, you will establish a **Bastion** session to **WGWEB1** and then initiate a **Remote Desktop (RDP)** connection to **WGSQL1** using its private IP address. The connection should be successful since it is allowed by **Azure Firewall**.

1. On the Azure portal, type **Virtual Machine (1)** in the search box and select **Virtual Machines (2)** from the results.

    ![](images/02032025(9).png)

1. On the **Virtual Machines** page, find and select **WGWEB1**.

    ![](images/02032025(20).png)

1. Click **Connect (1)** and choose **Connect via Bastion (2)** as the connection method.

    ![](images/02032025(21).png)

1. Enter the following credentials and click **Connect (3)**:  
   
   - **Username (1):** `demouser` 

   - **VM Password (2):** `demo@pass123`

     ![](images/02032025(22).png)

1. Within the **WGWEB1** Bastion session, search for **Remote Desktop Connection** in the Windows search bar and open the application.

    ![](images/02032025(16).png)

1. Enter **10.8.1.4** (the private IP of WGSQL1) in the **Computer** field and click **Connect**.

    ![](images/02032025(24).png)

1. Enter the following credentials and click **Connect (3)**:  

   - **Username (1):** `.\demouser` 

   - **Password (2):** `demo@pass123`

     ![](images/02032025(25).png)

1. If prompted with a security warning, click **Yes** to proceed.

    ![](images/02032025(26).png)

1. The RDP session to **WGSQL1** should be established successfully, confirming that Azure Firewall allows the connection.

This verifies that **WGWEB1** can communicate with **WGSQL1** over **RDP**, as permitted by **Azure Firewall**.

### Review
In this lab, you have completed:
- Created a virtual machine to validate connectivity
- Configured routing for simulated 'on-premises' to Azure traffic

## Great job on completing this exercise! You can now proceed to the next one.
