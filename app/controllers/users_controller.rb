class UsersController < ApplicationController
  before_action :authorize, :except => [:index, :new, :create]
  
  def new
    @user = User.new(params[:id])
    #@qualities = Quality.new(params[:id])
    #@skills = Skill.new(params[:id])
    @user.qualities.build
    @user.skills.build
  
  end


 def edit

  @user = User.find(params[:id])
# @user.find(params[:id])
    if @user.save
      redirect_to user_path
    end
  end

def update
 @user = User.find(params[:id])
 if @user.update_attributes(user_params)
    redirect_to dashboard_path
  else
    render :action => :edit
  end
end


def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    #@qualities = Quality.new(params[:id])
    #@skills = Skill.new(params[:id])

    #@user.users_qualities_skills.create( :user_id => @user.id, :quality_id => @qualities.id, :skill_id => @skills.id)


    if @user.save
      flash[:notice] = "you are a user now!"
      sign_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

private

def user_params 
  params.require(:user).permit(
     :email, :password, :password_confirmation, :admin, :first_name, :last_name, :quality_id, :skill_id, 
      {:qualities_attributes => [:quality]}, {:skills_attributes => [:skill]}
  )
end
end

#def person_params
 #    params.require(:person).permit(:name, :age)
 #  end
#nd