## Exercise 4: Create route tables with required routes

Route Tables are containers for User Defined Routes (UDRs). The route table is created and associated with a subnet. UDRs allow you to direct traffic in ways other than normal system routes would. In this case, UDRs will direct outbound traffic via the Azure firewall.

### Task 1: Create route tables

1. On the main portal menu, select **+ Create a Resource**. Type **route** into the search box, and select **Route table** then select **Create**.

2. On the **Create a Route table** blade enter the following information:

    - Subscription: **Select your subscription**.

    - Resource group: Select **WGVNetRG1** from the drop down.

    - Region: **South Central US**

    - Name: **MgmtRT**

    - Propagate gateway routes: **Yes**

3. When the dialog looks like the following screenshot, select **Review + Create** then **Create**.

    ![In this screenshot, the 'Create Route table' blade of the Azure portal is depicted with the required settings listed in the previous step highlighted.](images/hol-ex4-task1-create-route-table-basics.png "Create route table")

4. Repeat steps 1 and 2 to create the **AppRT** route table:

    - Subscription: **Select your subscription**.

    - Resource group: Select **WGVNetRG2** from the drop down.

    - Region: **South Central US**

    - Name: **AppRT**

    - Propagate gateway routes: **Yes**

5. Once route tables are created, your **Route tables** blade should look like the following screenshot:

    ![In this screenshot, the 'Route tables' blade of the Azure portal is depicted with the two route tables created in this task listed.](images/hol-ex4-task1-route-tables-blade.png "Route table link")

### Task 2: Add routes to each route table

1. Select the **AppRT** route table, and select **Routes** under **Settings** on the left.

    ![In this screenshot, the AppRT route table blade in the Azure portal is depicted with Routes in the Settings section of the navigation on the left highlighted.](images/hol-ex4-task2-routes-navigation.png "Route table blade ")

2. On the **Routes** blade, select **+ Add**. Enter the following information, and select **Add**:

    - Route name: **AppToInternet**

    - Address prefix destination: **IP Addresses**

    - Address prefix: **0.0.0.0/0**

    - Next hop type: **Virtual appliance**

    - Next hop address: **10.7.1.4** (This is the private IP of Azure Firewall.)

        ![In this screenshot, the 'Add route' blade of the AppRT route table in the Azure portal is depicted with the required settings listed above highlighted.](images/hol-ex4-task2-add-route-blade-app-to-internet.png "Add route configuration")

3. Repeat this procedure to add the **AppToMgmt** route using the following information:

    - Route name: **AppToMgmt**

    - Address prefix destination: **IP Addresses**

    - Address prefix: **10.7.0.8/29**

    - Next hop type: **Virtual appliance**

    - Next hop address: **10.7.1.4** (This is the private IP of Azure Firewall.)

        ![In this screenshot, the 'Add route' blade of the AppRT route table in the Azure portal is depicted with the required settings listed above highlighted.](images/hol-ex4-task2-add-route-blade-app-to-mgmt.png "Edit route")

4. Upon completion, your routes in the **AppRT** route table should look like the following screenshot:

    ![In this screenshot, the Routes blade of the AppRT route table is depicted with the two newly creates routes listed.](images/hol-ex4-task2-apprt-route-table.png "Route table ")

5. In the Azure Portal, go to All Services and type **route** in the search box and select **Route tables**.

6. Select **MgmtRT**, and select **Routes** under **Settings** on the left.

    ![In this screenshot, the 'Routes' blade of the Azure portal is depicted with the MgmtRT route table selected. The Routes option under the Settings section of the left navigation is highlighted.](images/hol-ex4-task2-mgmtrt-in-route-tables.png "MgmtRT")

7. On the **Routes** blade, select **+Add**. Enter the following information, and select **Add**:

    - Route name: **MgmtToOnPremises**

    - Address prefix destination: **IP Addresses**

    - Address prefix: **192.168.0.0/16**

    - Next hop type: **Virtual network gateway**

    - Next hop address: **Leave blank**.

        ![In this screenshot, the 'Add route' blade of the MgmtRT route table in the Azure portal is depicted with the required settings listed above highlighted.](images/hol-ex4-task2-add-route-blade-mgmt-to-onpremises.png "Add route")

8. Add the **MgmtToApp** route using the following information:

    - Route name: **MgmtToApp**

    - Address prefix destination: **IP Addresses**

    - Address prefix: **10.7.2.0/25**

    - Next hop type: **Virtual appliance**

    - Next hop address: **10.7.1.4** (This is the private IP of Azure Firewall.)

        ![In this screenshot, the 'Add route' blade of the MgmtRT route table in the Azure portal is depicted with the required settings listed above highlighted.](images/hol-ex4-task2-add-route-blade-mgmt-to-app.png "Add route")

9. Upon completion, your routes in the **MgmtRT** route table should look like the following screenshot:

    ![In this screenshot, the Routes blade of the MgmtRT route table is depicted with the two newly creates routes listed.](images/hol-ex4-task2-mgmtrt-route-table.png "Route table")

    >**Note:** The route tables and routes you have just created are not associated with any subnets yet, so they are not impacting any traffic flow yet. This will be accomplished later in the lab.