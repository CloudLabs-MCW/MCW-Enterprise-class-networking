## Exercise 9: Create a Network Monitoring Solution

## Lab objectives

In this lab, you will perform following tasks:

- Create a Log Analytics Workspace
- Configure Network Watcher
  
## Estimated timing: 20 minutes

### Task 1: Create a Log Analytics Workspace

1. In the search bar of the Azure portal, type **Log Analytics Workspace (1)**. From the search results, select **Log Analytics Workspace (2)**.

   ![](images/lab9log1.png)

1. Click on **Create**.

2. On the **Create workspace** blade, enter the following information:

    | Setting | Action |
    | -- | -- |
    | Subscription | **Select your subscription** |
    | Resource group | **MonitoringRG** |
    | Name | **Enter a unique name in all lowercase** |
    | Location | **East US** |

3. Upon completion, it should look like the following screenshot. Validate the information is correct, and select **Review + create** then **Create**.

    ![](images/hol-ex9-task1-create-log-analytics-workspace.png)

### Task 2: Configure Network Watcher

1. Connect to the Azure portal. Select **All Services** on the left navigation, and in the Category list, select **Networking** followed by selecting **Network Watcher**.

    ![](images/hol-ex9-task2-services-network-watcher.png)

2. In the **Overview** blade, ensure that **NetworkWatcher_southcentralus** and **NetworkWatcher_eastus** is listed.

3. If they are not listed, add them to the list using the **+ Add** button.

   ![](images/hol-ex9-task2-network-watcher.png)

### Review

In this lab, you have completed:
- Created a Log Analytics Workspace
- Configured Network Watcher

## Great job on completing this exercise! You can now proceed to the next one.
