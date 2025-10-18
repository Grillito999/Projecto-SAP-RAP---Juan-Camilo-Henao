@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Item Interface - 0098'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZCDS_I_ITEMS_0098
  as projection on ZCDS_R_ITEM_0098

{
  key ItemUUID,

      HeaderUUID,
      ItemID,

      @Semantics.name.fullName: true
      Name,

      @Semantics.text: true
      Description,

      ReleaseDate,
      DiscontinueDate,

      @Semantics.amount.currencyCode: 'Currency'
      Price,

      Currency,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Height,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Width,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Depth,

      Quantity,
      UnitOfMeasure,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Associations */
      _Currency,
      _Header : redirected to parent ZCDS_I_HEADER_0098,
      _UnitMeasure
}
