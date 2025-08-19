

class ModelBase<T>{
   bool isSuccess;

   T? data;

   String? message;

  ModelBase({this.isSuccess = false, this.data, this.message});
}