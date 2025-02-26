## Exercise 2: Virtual Network Peering

## Lab objectives

In this lab, you will perform following tasks:

- Configure VNet peering WGVNet1 to WGVNet2 and Vice Versa
  
## Estimated timing: 20 minutes

### Task 1: Configure VNet peering WGVNet1 to WGVNet2 and Vice Versa

1. Select the resource group **WGVNetRG1**, and select the configuration blade for **WGVNet1**. Select **Peerings** under **Settings** on the left.

2. Select **+ Add**.

    ![In this screenshot, the Peerings blade of the WGVNet1 Virtual Network resources is depicted. With the '+ Add' button selected.](images/hol-ex2-task1-add-peerings-button.png "Virtual network blade")

3. Set the following configuration for the new peering. Select **Add** to create the peering.

    **Remote virtual network summary**

    | Setting | Action |
    | -- | -- |
    | **Peering link name** | **VNETPeering_WGVNet2-WGVNet1** **(1)** |
    | **Virtual network deployment model** | **Resource Manager** **(2)** |
    | **Virtual Network** | **WGVNet2 (WGVNetRG2) (3)** |

    ![](images/lab1vnet14.png)

1. Enable the following checkboxes for **Remote virtual network peering settings**

    - Allow the peered virtual network to access 'WGVNet1'
    - Allow the peered virtual network to receive forwarded traffic from 'WGVNet1'
    - Allow the gateway or route server in the peered virtual network to forward traffic to 'WGVNet1'

      ![](images/lab1vnet15.png)

1. For **Local virtual network summary** provide the Peering link name as **VNETPeering_WGVNet1-WGVNet2** **(1)**

1. Enable the following checkboxes for **Local virtual network peering settings**

    - Allow 'WGVNet1' to access the peered virtual network

    - Allow 'WGVNet1' to receive forwarded traffic from the peered virtual network

    - Allow gateway or route server in 'WGVNet1' to forward traffic to the peered virtual network

      ![](images/lab1vnet16.png)

### Review
In this lab, you have completed:
- Configured VNet peering WGVNet1 to WGVNet2 and Vice Versa

## Great job on completing this exercise! You can now proceed to the next one.
