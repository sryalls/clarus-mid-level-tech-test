# Orders Resource API

## Place
### Request
`PUT /order/:warehouse_id:/:product_id/:quantity`

### Responses

|type|code|description|
|-|-|-|
|success| 200||
|server error| 500||
|warehouse not found|412| The spefified warehouse does not exist|
|product not found| 412 | The ordered product does not exist in the inventory for the speficied warehouse. Takes precidence over insufficient stock. Order fails for all items in order.|
|insufficient stock| 202 | The ordered products has fewer items in storage than has been ordered. Order fails for all items in the order.|

## Dispatch
### Request
`PUT /order/:id/dispatch`

### Responses

|type|code|description|
|-|-|-|
|success| 200||
|server error|500||
|stock error| 500| The order cannot be fulfilled because there are no longer enough items available. |

## List
### Request
`GET /orders`

### Responses

|type|code|description|
|-|-|-|
|success| 200|`{['warehouse_id': [{'order_id', 'product_id', number requested, 'status, ''created_at'}]]}`|
|server error| 500||