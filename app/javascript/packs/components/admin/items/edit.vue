<template lang="pug">
  .content
    h2 {{ $t("admin.items.edit.title") }}
    el-form(label-width="120px")
      el-form-item(:label="$t('labels.Name')")
        el-input(v-model="item.name", autofocus)
      el-form-item(:label="$t('labels.Rate')")
        el-input(v-model="item.rate")
      el-form-item
        el-button(type="primary", native-type="submit", @click="save") {{ $t("labels.Save") }}
</template>

<script lang="coffee">
  import Item from "../../../resources/admin/item"

  export default {
    data: ->
      item: new Item()
    methods:
      save: (event) ->
        event.preventDefault()
        @item.save().subscribe(
          (response) =>
            @$notify.success(message: @$i18n.t("messages.saved"))
            @$router.push(name: "items")
        )
    mounted: ->
      id = @$route.params.id
      return unless id
      Item.get(id: id).subscribe(
        (response) =>
          @item = response.data
      )
  }
</script>