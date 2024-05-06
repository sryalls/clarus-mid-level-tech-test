# Stocks Resource API

## Intake

### Request
`PUT /stocks/:warehouse_id:/:product_id/:quantity`

### Responses

|type|code|description|
|-|-|-|
|success| 200||
|server error| 500||
|warehouse not found|412| The spefified warehouse does not exist|
|product not found| 412 | The ordered product does not exist in the inventory for the speficied warehouse.|
|Non integer quantitiy| 400| Quantity must be an integer|

## Levels

### Request
`GET /stocks`

### Responses

|type|code|data|description|
|-|-|-|-|
|success| 200|`{warehouse_code: [{'product_code': ABC123, 'total': 15, 'reserved': 5}]}`|'total' is the number of items currently in stock including 'reserved' items. <br><br>'reserved' is the number of items required to fulfill existing orders|
|server error| 500|||