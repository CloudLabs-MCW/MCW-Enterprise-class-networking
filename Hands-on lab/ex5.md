## Exercise 5: Configure n-tier application and validate functionality

In this exercise, you will create and configure a load balancer to distribute the load between the web servers.

## Lab objectives

In this lab, you will perform following tasks:

- Create a load balancer to distribute the load between the web servers
- Configure the load balancer
  
## Estimated timing: 60 minutes

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

    Ensure your **Create load balancer** dialog looks like the following, and select **Next: Frontend IP configuration (8)** then select **Create**.

    ![](images/lab5loadb1a.png)

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

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="9867053a-f34e-4a74-8f92-f05a6c075ae2" />

### Task 2: Configure the load balancer

1. Open the **WGWEBLB** load balancer in the Azure portal.

2. Select **Backend pools**, and select **+Add** at the beginning.

    ![In this screenshot, the Azure portal blade for the WGWEBLB load balancer is depicted with Backend pools' selected on the left and the '+ Add' button selected.](images/hol-ex5-task2-backend-pools-add-button.png "Load balancer blade")

3. Enter **LBBE (1)** for the pool name. Select **NIC (2)** for **Backend Pool Configuration**. Under **IP Configurations**, select **+ Add (3)**.

    ![](images/lab5loadb2a.png)

4. Under **Virtual machine**, select **+ Add** and choose the **WGWEB1** and **WGWEB2** virtual machines and select **Add**.

    ![](images/lab5loadb3.png)

5. Select **Save** at the bottom of the **Add backend pool** blade to add the backend pool.

6. Wait to proceed until the Backend pool configuration is finished updating. When the backends are added, they should look like the following image.

    ![](images/lab5loadb4.png)

7. Next, under **Settings** on the WGWEBLB Load Balancer blade, select **Health Probes**. Select **+ Add**, and use the following information to create a health probe.

    - Name: **HTTP**

    - Protocol: **HTTP**

        ![](images/hol-ex5-task2-health-probes-add-button.png)

        ![](images/lab5loadb4a.png)

8. Select **Save**.

9. After the Health probe has been added, select **Load balancing rules (1)** from the left navigation. Select **+ Add (2)** and complete the configuration as shown below followed by selecting **Add**.

    ![](images/lab5loadb4b.png)

    | Setting | Action |
    | -- | -- |
    | Name | **HTTP** **(1)** |
    | Frontend IP address | **WGWEBLBIP 10.8.0.100** **(2)** |
    | Backend pool | **LBBE** **(3)** |
    | Port | **80** **(4)** |
    | Backend port | **80** **(5)** |
    | Health probe | **HTTP** **(6)** |

    ![](images/lab5loadb5.png)

1. In the search bar of the Azure portal, type **Virtual machines (1)**. From the search results, select **Virtual machines (2)**.

    ![](images/lab5loadb5a.png)

1. Select **WGWEB1** virtual machine.

    ![](images/lab5loadb5b.png)

1. On **WGWEB1**, click **Connect (1)** and select **Connect via Bastion (2)**.

    ![](images/lab5loadb6.png)

1. Enter the **Username** as **demouser (1)** and the **VM Password** as **demo@pass123 (2)**, then click **Connect (3)**.

    ![](images/lab5loadb7.png)

1. If you receive an error message like the one shown in the screenshot, follow these steps:

    ![](images/lab5loadb7a.png)

1. Click on the **pop-up (1)** icon from the browser bar, select **Always allow pop-ups and redirects from https://portal.azure.com (2)**, and then click **Done**.  

    ![](images/lab5loadb7b.png)

1. Now, click on **Connect** again.

    ![](images/lab5loadb7d.png)

1. It will open a new page, click on the **Allow**

    ![](images/lab5loadb7c.png)

10. Within WGWEB1, open **Microsoft Edge** from the Start menu and navigate to <http://10.8.0.100>. Ensure that you successfully connect to either one of the two Web servers.

    ![](images/hol-ex5-task2-cloudshop-demo-on-wgweb1.png)

    ![](images/hol-ex5-task2-cloudshop-demo-on-wgweb2.png)

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
      
   - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task.
   - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   - If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

<validation step="98be1945-3a24-4466-927f-45b7592578c8" />

### Review
In this lab, you have completed:
- Created a load balancer to distribute the load between the web servers
- Configured the load balancer

## Great job on completing this exercise! You can now proceed to the next one.
