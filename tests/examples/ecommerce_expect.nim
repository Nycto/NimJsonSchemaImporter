type
  EcommerceItems* = object
    `name`*: string
    `price`*: BiggestFloat
  EcommerceEcommerce* = object
    `items`*: seq[EcommerceItems]
    `orderId`*: string