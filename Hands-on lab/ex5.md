## Exercise 5: Configure n-tier application and validate functionality

In this exercise, you will create and configure a load balancer to distribute the load between the web servers.

### Task 1: Create a load balancer to distribute the load between the web servers

1. In the search bar of the Azure portal, type **Load balancers (1)**. From the search results, select **Load balancers (2)**.

    ![](images/lab5loadb1.png)

2. On the **Create load balancer** blade, on the **Basics** tab, enter the following values:

    | Setting | Action |
    | -- | -- |
    | Subscription | Select your subscription **(1)** |
    | Resource group | **WGVNetRG2** **(2)** |
    | Name | **WGWEBLB** **(3)** |
    | Region | **South Central US (4)** |
    | SKU | **Standard** **(5)** |
    | Type | **Internal** **(6)** |
    | Tier | **Regional** **(7)**|

    Ensure your **Create load balancer** dialog looks like the following, and select **Next: Frontend IP configuration** then select **Create**.

    ![](images/hol-ex5-task1-create-load-balancer-wgweblb.png)

3. On the **Frontend IP configuration** tile, select **+ Add a frontend IP configuration** and enter the following values:

    | Setting | Action |
    | -- | -- |
    | Name | **WGWEBLBIP** **(1)** |
    | Virtual network | **WGVNet2** **(2)** |
    | Subnet | **AppSubnet (10.8.0.0/25)** **(3)** |
    | Assignment | **Static** **(4)** |
    | IP address | **10.8.0.100** **(5)** |
    | Availability zone | **1** **(6)** |

    Ensure your **Create load balancer - Frontend IP configuration** dialog looks like the following, and select **Save (7)**.

    ![](images/lab5loadb2.png)

4. Select **Review + create**, and then select **Create**.

    >**Note**: **Backend pools** can now be configured within the **Create Load balancer** wizard.  For this exercise, we will complete this in the next task to show where to find it on the resource.

### Task 2: Configure the load balancer

1. Open the **WGWEBLB** load balancer in the Azure portal.

2. Select **Backend pools**, and select **+Add** at the beginning.

    ![In this screenshot, the Azure portal blade for the WGWEBLB load balancer is depicted with Backend pools' selected on the left and the '+ Add' button selected.](images/hol-ex5-task2-backend-pools-add-button.png "Load balancer blade")

3. Enter **LBBE** for the pool name. Select **NIC** for **Backend Pool Configuration**. Under **IP Configurations**, select **+ Add**.

    ![In this screenshot, the 'Add backend pool' blade is depicted with the Name and 'Associated to' fields filled in as listed above.](images/hol-ex5-task2-add-backend-pool.png "Add backend pool blade")

4. Under **Virtual machine**, select **+ Add** and choose the **WGWEB1** and **WGWEB2** virtual machines and select **Add**.

    ![](images/lab5loadb3.png)

    >**Note**: If you do not see WGWEB1 in the Virtual Machine selection list, the public IP address was not created as a Standard SKU.  Locate **webip** and in the **Overview** tile, select the **Upgrade to Standard SKU** banner to change the SKU.  You will need to change the IP to **Static** in the **Configuration** and temporarily **Disassociate** it from **WGWEB1NetworkInterface**. Once upgraded, **Associate** webip with the **Network Interface** for WGWEB1.

    ![In this screenshot, the upgrade to standard sku will take you through the process of upgrading the public IP address.](images/hol-ex5-task2-upgrade-ip-address-sku.png "Upgrade Public IP from Basic to Standard")

5. Select **Save** at the bottom of the **Add backend pool** blade to add the backend pool.

6. Wait to proceed until the Backend pool configuration is finished updating. When the backends are added, they should look like the following image.

    ![](images/lab5loadb4.png)

7. Next, under **Settings** on the WGWEBLB Load Balancer blade, select **Health Probes**. Select **+ Add**, and use the following information to create a health probe.

    - Name: **HTTP**

    - Protocol: **HTTP**

        ![In this screenshot, the 'WGWEBLB' load balancer blade of the Azure portal is depicted with 'Health probes' under 'Settings' in the left navigation highlighted.](images/hol-ex5-task2-health-probes-add-button.png "Settings section, Add health probe blade")

        ![In this screenshot, the 'Add health probe' blade is depicted with the required settings listed above selected along with the Add button selected.](images/a1.6.png "Add health probe blade")

8. Select **Add**.

9. After the Health probe has been added, select **Load balancing rules** from the left navigation. Select **+ Add** and complete the configuration as shown below followed by selecting **Add**.

    | Setting | Action |
    | -- | -- |
    | Name | **HTTP** **(1)** |
    | Frontend IP address | **10.8.0.100** **(2)** |
    | Backend pool | **LBBE** **(3)** |
    | Port | **80** **(4)** |
    | Backend port | **80** **(5)** |
    | Health probe | **HTTP** **(6)** |

    ![](images/lab5loadb5.png)

1. On **WGWEB1**, click **Connect (1)** and select **Connect via Bastion (2)**.

    ![](images/lab5loadb6.png)

1. Enter the **Username** as **demouser (1)** and the **VM Password** as **demo@pass123 (2)**, then click **Connect (3)**.

    ![](images/lab5loadb7.png)

10. Within WGWEB1, open **Microsoft Edge** from the Start menu and navigate to <http://10.8.0.100>. Ensure that you successfully connect to either one of the two Web servers.

    ![](images/hol-ex5-task2-cloudshop-demo-on-wgweb1.png)

    ![](images/hol-ex5-task2-cloudshop-demo-on-wgweb2.png)

11. Using the portal, disassociate the public IP from the NIC of **WGWEB1NetworkInterface** VM. Do this by navigating to the VM and selecting **Network settings (1)** under **Networking** on the left. Select the **NIC Public IP (2)**. 

    ![](images/lab5loadb10.png)

1. Then choose **Dissociate**. Select **Yes** when prompted.

   ![](images/lab5loadb8.png)
   ![](images/lab5loadb9.png)