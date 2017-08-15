<template lang="pug">
  .grid-layout.navbar
    .left
      el-row
        el-button.el-col(type="text" @click="home") {{ logo }}
        el-button.el-col(type="text" @click="items") {{ item }}
    .right
      el-dropdown(trigger="click", @command="performCommand")
        span.el-dropdown-link {{ $auth.name() }}
        el-dropdown-menu(slot="dropdown")
          el-dropdown-item(command="logout")
            icon(name="sign-out")
            span {{ $t("labels.Logout") }}
</template>

<script lang="coffee">
  export default {
    data: ->
      logo: "VueSample"
      item: "Item"
    methods:
      performCommand: (command) ->
        switch command
          when "logout"                      
            @$auth.logout()
      home: ->
        @$router.push(name: "influencers")
      items: ->
        @$router.push(name: "items")           
  }
</script>

<style lang="sass" scoped>
  .navbar
    padding: 10px
    background-color: #eef1f6

  .el-dropdown-link:hover
    cursor: pointer
    color: #20a0ff // var(--color-primary)
    .el-row
      margin-bottom: 20px
      &:last-child
        margin-bottom: 0
    .el-col
      border-radius: 4px

    .bg-purple-dark
      background: #99a9bf

    .bg-purple
      background: #d3dce6

    .bg-purple-light
      background: #e5e9f2

    .grid-content
      border-radius: 4px
      min-height: 36px

    .row-bg
      padding: 10px 0
      background-color: #f9fafc
</style>