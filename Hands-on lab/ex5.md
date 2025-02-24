## Exercise 5: Configure n-tier application and validate functionality

In this exercise, you will create and configure a load balancer to distribute the load between the web servers.

### Task 1: Create a load balancer to distribute the load between the web servers

1. In the Azure portal, from the home page navigation, select **Load balancers**, then select **+ Create**.

    ![In this screenshot, the navigation from the Azure portal home page is expanded. The hamburger menu (three stacked lines) and 'Load balancers' option are highlighted.](images/hol-ex5-task1-load-balancer-navigation.png)

2. On the **Create load balancer** blade, on the **Basics** tab, enter the following values:

    - Subscription: **Select your subscription**.

    - Resource group: **WGVNetRG2**

    - Name: **WGWEBLB**

    - Region: **South Central US**

    - SKU: **Standard**

    - Type: **Internal**

    - Tier: **Regional**

    Ensure your **Create load balancer** dialog looks like the following, and select **Next: Frontend IP configuration** then select **Create**.

    ![In this screenshot, the 'Create load balancer' blade is depicted with the required settings listed above and the 'Next: Frontend IP configuration' button highlighted.](images/hol-ex5-task1-create-load-balancer-wgweblb.png "Create load balancer")

3. On the **Frontend IP configuration** tile, select **+ Add a frontend IP configuration** and enter the following values:

    - Name: **WGWEBLBIP**

    - Virtual network: **WGVNet2**

    - Subnet: **AppSubnet (10.8.0.0/25)**

    - Assignment: **Static**

    - IP address: **10.8.0.100**

    - Availability zone: **1**

    Ensure your **Create load balancer - Frontend IP configuration** dialog looks like the following, and select **Add**.

    ![In this screenshot, the 'Frontend IP configuration' blade is depicted with the required settings listed above as well as the Add button highlighted.](images/hol-ex5-task1-frontend-ip-config.png "Frontend IP configuration")

4. Select **Review + create**, and then select **Create**.

    >**Note**: **Backend pools** can now be configured within the **Create Load balancer** wizard.  For this exercise, we will complete this in the next task to show where to find it on the resource.

### Task 2: Configure the load balancer

1. Open the **WGWEBLB** load balancer in the Azure portal.

2. Select **Backend pools**, and select **+Add** at the beginning.

    ![In this screenshot, the Azure portal blade for the WGWEBLB load balancer is depicted with Backend pools' selected on the left and the '+ Add' button selected.](images/hol-ex5-task2-backend-pools-add-button.png "Load balancer blade")

3. Enter **LBBE** for the pool name. Select **NIC** for **Backend Pool Configuration**. Under **IP Configurations**, select **+ Add**.

    ![In this screenshot, the 'Add backend pool' blade is depicted with the Name and 'Associated to' fields filled in as listed above.](images/hol-ex5-task2-add-backend-pool.png "Add backend pool blade")

4. Under **Virtual machine**, select **+ Add** and choose the **WGWEB1** and **WGWEB2** virtual machines and select **Add**.

    ![In this screenshot, the 'Add IP configurations to backend pool' blade is depicted with WGWEB1 and WGWEB2 options highlighted and checked. The Add button is also highlighted.](images/hol-ex5-task2-add-vms-to-backend-pool.png)

    >**Note**: If you do not see WGWEB1 in the Virtual Machine selection list, the public IP address was not created as a Standard SKU.  Locate **webip** and in the **Overview** tile, select the **Upgrade to Standard SKU** banner to change the SKU.  You will need to change the IP to **Static** in the **Configuration** and temporarily **Disassociate** it from **WGWEB1NetworkInterface**. Once upgraded, **Associate** webip with the **Network Interface** for WGWEB1.

    ![In this screenshot, the upgrade to standard sku will take you through the process of upgrading the public IP address.](images/hol-ex5-task2-upgrade-ip-address-sku.png "Upgrade Public IP from Basic to Standard")

5. Select **Save** at the bottom of the **Add backend pool** blade to add the backend pool.

6. Wait to proceed until the Backend pool configuration is finished updating. When the backends are added, they should look like the following image.

    ![In this screenshot, the 'WGWEBLB - Backend pools' blade of the Azure portal is depicted. The two virtual machines in the backend pool show a status of running, indicating that the backend pool configuration is complete.](images/hol-ex5-task2-backend-pools.png "Backend pool blade")

7. Next, under **Settings** on the WGWEBLB Load Balancer blade, select **Health Probes**. Select **+ Add**, and use the following information to create a health probe.

    - Name: **HTTP**

    - Protocol: **HTTP**

        ![In this screenshot, the 'WGWEBLB' load balancer blade of the Azure portal is depicted with 'Health probes' under 'Settings' in the left navigation highlighted.](images/hol-ex5-task2-health-probes-add-button.png "Settings section, Add health probe blade")

        ![In this screenshot, the 'Add health probe' blade is depicted with the required settings listed above selected along with the Add button selected.](images/a1.6.png "Add health probe blade")

8. Select **Add**.

9. After the Health probe has been added, select **Load balancing rules** from the left navigation. Select **+ Add** and complete the configuration as shown below followed by selecting **Add**.

    - Name: **HTTP**

    - Frontend IP address: Select the load balancer IP entry with **10.8.0.100**.

    - Backend pool: **LBBE**

    - Port: **80**

    - Backend port: **80**

    - Health probe: **HTTP**

        ![In this screenshot, the 'Add load balancing rule' blade of the Azure portal is depicted with the required settings listed above and the Add button highlighted.](images/a1.7.png "Add load balancing rule")

10. Navigate to WGWEB1 in the Azure portal. Connect to WGWEB1 via Bastion. Within WGWEB1, open Microsoft Edge from the Start menu and navigate to <http://10.8.0.100>. Ensure that you successfully connect to either one of the two Web servers.

    ![In this screenshot, the web page that appears when you navigate to the load balancer IP address appears indicating that your successfully connected to the WEB1 web server.](images/hol-ex5-task2-cloudshop-demo-on-wgweb1.png "Server response for the CloudShop demo on WGWEB1")

    ![In this screenshot, the web page that appears when you navigate to the load balancer IP address appears indicating that your successfully connected to the WEB2 web server.](images/hol-ex5-task2-cloudshop-demo-on-wgweb2.png "Server response for the CloudShop demo on WGWEB1")

11. Using the portal, disassociate the public IP from the NIC of **WGWEB1** VM. Do this by navigating to the VM and selecting **Networking** under **Settings** on the left. Select the **NIC Public IP** then choose **Dissociate**. Select **Yes** when prompted.

    ![In this screenshot, the WGWEB1 - Networking blade of the Azure portal is depicted with the NIC Public IP selected.](images/hol-ex5-task2-wgweb1-dissociate-ip-address.png "Virtual machine networking blade")

12. Next, return to the **WGWEB1 - Networking** blade and select the **Network Interface**.

13. Select **IP configurations** under **Settings** on the left.

    ![In this screenshot, the network interface page for the web server on the Azure portal is depicted with 'IP configuration' in the left navigation highlighted.](images/hol-ex5-task2-ip-configurations.png "Network interface blade")

14. Next, select **ipconfig1** shown above.

15. Select and make sure that the **Public IP address settings** is shown as **Dissociate**, and select **Save** if necessary. This should remove the public IP address from the network interface of the VM.

    ![In this screenshot, the 'ipconfig1' blade of the web server NIC is depicted with the 'Public IP address' set to 'Disassociate' and the Save button selected.](images/hol-ex5-task2-ipconfig1-dissociate.png "IP configuration blade")
