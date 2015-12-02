# Edit/Update Action

## Objectives

1. Use form_tag to build an edit form that submits a PUT to update action
2. Use form_tag and input helpers to prefill form fields based on an AR instance
3. Find an instance to edit using a dynamic route
4. Describe the input hack and how to manually trigger another HTTP method
5. Manually update an instance based on form data
6. Use update to mass assign data from params to a post to update redirect to show
7. Explain the problems with form_tag for an edit page


## Notes

let's build an edit and update form that uses form_tag

edit/update is more complex then new/create but we're dealing with existing data.

posts#edit needs to find the post we're talking about which means that /posts/:id/edit route.

then we render the edit_form.html

we need to point to a different action with a different non support method

first, what's the URL or named route for the form_tag? post_path(@post). submit the form with that, we get to post show because the form submitted with a GET/POST request instead of a PUT request.

the _input hack passing :method to form_tag automatically embeds input hack in your form.

now that we have the form wrapper pointing to the write action/url with the method hack, what else is different about our edit form vs our new form?

the edit form needs to pre fill.

Let's use @post from the controller to prefill the value attribute of our inputs with text_field_tag 'post_title', :value => @post.title (or is it just the 2nd argument)

Now the form looks good.

Let's use the same debugging technique we did when we built the new form and create action, and it's a good habbit to develop in general when building a form, before implementing the receiving action completely, you should raise params.inspect and make sure the form is submitting to the controller#action you expect and that the form is passing data correctly via params. You should be able to perdict what params looks like from the name attribute of your input fields.

in update lets raise params.inspect, submit, and there it is everything looks good.

What does update need to do in the action?

similar to edit, the first step is to simply find the post we're talking about.

once we found it, how can we update that instance?

manually, or let's use .update(:title => params[:post_title]). hm, that mass assignment seems like it could be easier...why can't we just pass params in entirely? what would we need to format params as in order to simply pass it or one of it's keys entirely to update?

so we manually assign and save, or use update, and then we can redirect to post show and that's the edit / update flow.

another thing we don't like is that form is really dirty. lots of repitition. Is there a better way to build forms and controller actions that process them then doing all this reptitive work when there is clearly a pattern here?

what's the pattern - the post is about fields for the @post object and the udate logic corresponds to the fields in the form.

Bonus: Are we updating the entire post or only the fields the change?

in the event you only edit the title, does the post content get updated if we are always assigning all fields? dirty_attributes like content_changed? internalized in the sql for save/update (is that true?)

<a href='https://learn.co/lessons/rails-edit-update-action-readme' data-visibility='hidden'>View this lesson on Learn.co</a>
