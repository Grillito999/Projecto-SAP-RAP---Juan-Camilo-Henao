@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status VH 0098'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZCDS_OrderStatusVH_0098
  as select from zorderstavh_0098
{

      @ObjectModel.text.element: ['description']
  key orderstatus as Orderstatus,
      @Semantics.text: true
      description as Description
}
