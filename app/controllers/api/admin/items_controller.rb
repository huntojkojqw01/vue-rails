module Api
  module Admin
    class Api::Admin::ItemsController < ApplicationController
      def index
        records = sort(filter(::Item.all))
        render json: { meta: { count: records.count }, data: paginate(records) }
      end

      def show
        item = ::Item.find(params[:id])
        render json: { data: item }
      end

      def create
        item = ::Item.new(item_params)

        if item.save
          head :ok
        else
          render_validation_error(item)
        end
      end

      def update
        item = ::Item.find(params[:id])
        item.attributes = item_params

        if item.save
          head :ok
        else
          render_validation_error(item)
        end
      end

      def destroy
        ::Item.destroy(params[:id])
        head :ok
      end

      private

      def filter(records)
        name  = params.dig(:filter, :name)
        records = records.where("name LIKE ?", "%#{name}%")   if name.present?
        records
      end

      def sort(records)
        order_params = params[:sort].to_s.split(",").map do |sort|
          [sort.delete("-"), sort.start_with?("-") ? :desc : :asc]
        end.to_h
        records.order(order_params)
      end

      def paginate(records)
        page = params.dig(:page, :number)&.to_i || 1
        size = params.dig(:page, :size)&.to_i || 20
        records.page(page).per(size)
      end
      def item_params
        params.permit(:name, :rate)
      end
    end
  end
end