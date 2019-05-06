class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]


  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @parent = @student.parent
    @address = @parent.address
  end

  # POST /students
  # POST /students.json
  def create
    parent = Parent.where(ph_no: parent_params[:ph_no], govt_proof: parent_params[:govt_proof]).first_or_create(parent_params.merge(address: params[:student]["address"].as_json))
    @student = parent.students.new(student_params)
    # client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    # client.messages.create(from: ENV["TWILIO_NUMBER"], body: "Thank's for attaching with our AmaraatiS Organisation", to: '+917780759774')
    # client.messages.create(from: ENV["TWILIO_NUMBER"], body: "Thank's for attaching with our AmaraatiS Organisation", to: '+918125176201')
    # StudentMailer.student_email(@student).deliver!
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        @student.parent.update(parent_params.merge(address: params[:student]["address"].as_json))
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:roll_no, :first_name, :middle_name, :last_name, :dob, :age, :teacher_id)
    end

    def parent_params
      params[:student].require(:parent).permit(:roll_no, :first_name, :middle_name, :last_name, :dob, :age, :ph_no, :govt_proof, address: [:h_no, :street, :mandle, :city, :state, :pincode])
    end
end
