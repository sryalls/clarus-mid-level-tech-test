# Orders Resource API

## Place
### Request
`PUT /orders/:warehouse_id:/:product_id/:quantity`

### Responses

|type|code|description|
|-|-|-|
|success| 200| `{ job_id: '1232131' }`|
|server error| 500||
|warehouse not found|412| The spefified warehouse does not exist|
|product not found| 412 | The ordered product does not exist in the inventory for the speficied warehouse.|
|Non integer quantitiy| 400| Quantity must be an integer|

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