@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Item- 0098'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true

define view entity ZCDS_R_ITEM_0098
  as select from zitem_0098
  association        to parent ZCDS_R_HEADER_0098 as _Header      on $projection.HeaderUUID = _Header.HeaderUUID
  association [1..1] to I_Currency                as _Currency    on $projection.Currency = _Currency.Currency
  association [1..1] to I_UnitOfMeasureStdVH      as _UnitMeasure on $projection.UnitOfMeasure = _UnitMeasure.UnitOfMeasure

{
  key id                    as ItemUUID,
      header_id             as HeaderUUID,
      item_id               as ItemID,
      @Semantics.name.fullName: true
      name                  as Name,
      @Semantics.text: true
      description           as Description,
      release_date          as ReleaseDate,
      discontinue_date      as DiscontinueDate,
      @Semantics.amount.currencyCode: 'Currency'
      price                 as Price,
      currency              as Currency,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      height                as Height,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      width                 as Width,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      depth                 as Depth,
      quantity              as Quantity,
      unit_of_measure       as UnitOfMeasure,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      /* Associations */
      _Header,
      _Currency,
      _UnitMeasure
}
