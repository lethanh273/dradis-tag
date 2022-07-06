class TagsController < AuthenticatedController
  
    def index; 
       @tags = Tag.all
    end
  
    def new
       @tag = Tag.new
    end
  
    def create
      @tag = Tag.new(tag_params)   

      if @tag.save
        redirect_to tags_path, notice: 'Tag created'
      else
        render :new
      end
    end
  
    def edit
      @tag = Tag.find(params[:id])   
    end
  
    def update
      @tag = Tag.find(params[:id])   
      if @tag.update(tag_params)
        redirect_to tags_path, notice: 'Tag updated'
      else
        render :edit
      end
    end
  
    def destroy
      @tag = Tag.find(params[:id])   
      @tag.destroy
      redirect_to tags_path, notice: 'Tag destroyed'
    end
  
    private
  
    def tag_params
      params.require(:tag).permit(:name)
    end
  end