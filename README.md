# Edit/Update Action

Now that you know how to implement a create action the next logical step will be to integrate an edit/update action. As you may have noticed, there is a trend in Rails conventions where the logic for rendering a form is separate from the action that the manages the database record alteration. For example:

* The `new` action in the controller simply rendering the `new` form

* The `create` action is what actually handled the process for inserting the form data into the database

In like fashion, the `edit` and `update` actions have a similar convention:

* The `edit` action will handle rendering the `edit` form

* The `update` action will be the method that updates the database record itself

