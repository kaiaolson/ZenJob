class RelationshipsController < ApplicationController

  def new
    @relationship = Relationship.new
  end

  def create
    @relationship = current_user.relationships.build(relation_id: params[:relation_id])
    if @relationship.save
      flash[:notice] = "Added client."
      redirect_to root_url
    else
      flash[:error] = "Unable to add client."
      redirect_to root_url
    end
  end

  def destroy
    @relationship = current_user.relationships.find(params[:id])
    @relationship.destroy
    flash[:alert] = "Removed client."
    redirect_to root_url
  end
end
