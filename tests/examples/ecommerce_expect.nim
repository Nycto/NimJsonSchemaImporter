type
  items* = object
    name*: string
    price*: BiggestFloat
  ecommerce* = object
    items*: seq[items]
    orderId*: string