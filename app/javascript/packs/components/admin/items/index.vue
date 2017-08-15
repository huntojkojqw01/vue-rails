<template>
  <div class="content">
    <h2> {{ $t("admin.items.list.title") }} </h2>

    <el-form :inline="true" label-width="120px">
      <el-form-item :label="$t('labels.Name')">
        <el-input v-model="queryParams.filter.name" autofocus></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" native-type="submit" @click="query"> {{ $t("labels.Search") }}</el-button>
      </el-form-item>
    </el-form>
    <el-button @click="add()" size="small">New</el-button>
    <el-pagination layout="sizes, prev, pager, next"
        :page-sizes="queryParams.pageSizes"
        :page-size="queryParams.page.size"
        :total="count"
        @size-change="changePageSize"
        @current-change="changePage">
    </el-pagination>
    <el-table
      :data="items"
      v-loading.body="isLoading()"
      :default-sort = "{ prop: 'name', order: 'ascending' }"
      @selection-change="changeSelection"
      @sort-change="changeSort"
      stripe
      style="width: 100%">
      <el-table-column
        prop="name"
        label="Name"
        sortable>
      </el-table-column>
      <el-table-column
        prop="rate"
        label="Rate"
        sortable>
      </el-table-column>
      <el-table-column
        fixed="right"
        width="200">
        <template scope="scope">
          <el-button @click="edit(scope.row)" size="small">Edit</el-button>
          <el-button @click="remove(scope.row)" type="danger" size="small">Delete</el-button>
        </template>
      </el-table-column>
    </el-table>
</div>
</template>
<script lang="coffee">
  import Item from "../../../resources/admin/item"
  import QueryParams from "../../../resources/query_params"
  export default {
    data: ->
      queryParams: new QueryParams()
      items: []
      count: 0
      selection:   []
    methods:
      query: (event = null) ->
        event?.preventDefault()
        Item.query(@queryParams.toQuery()).subscribe(
          (response) =>
            @items = response.data
            @count = response.meta.count
        )
      index: ->
        Item.query().subscribe(
          (response) =>
            @items = response.data
        )
      changeSort: (sort) ->
        @queryParams.setSort(sort)
        @query()
      changeSelection: (value) ->
        @selection = value
      changePageSize: (size) ->
        @queryParams.changePageSize(size)
        @query()
      changePage: (page) ->
        @queryParams.changePage(page)
        @query()
      isLoading: ->
        Item.isLoading()
      add: ->
        @$router.push(name: "new item")
      edit: (item) ->
        @$router.push(name: "edit item", params: { id: item.id })
      remove: (item) ->
        item.delete().subscribe(
          =>
            @$notify.success(message: @$i18n.t("messages.deleted"))
            @query()
        )
    mounted: ->
      @queryParams.update(@$route.query)
  }
</script>
<style>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>