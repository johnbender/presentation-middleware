!SLIDE link
# Middleware: <br/> A General Abstraction

johnbender.github.com/presentation-middleware

!SLIDE bullets mono-bullets
## me
* @johnbender
* johnbender.us
* github.com/johnbender

!SLIDE center
<img src="adobe.jpg" style="max-height: 600px"></img>

!SLIDE
# Large Classes
### ε(´סּ︵סּ`)з

!SLIDE
## Mixin All The Things
### (╯°□°)╯︵ ┻━┻

!SLIDE
<pre class="xxlarge">
<span class="keyword">module</span> <span class="type">Authlogic</span>
  <span class="keyword">module</span> <span class="type">Session</span> <span class="comment-delimiter"># </span><span class="comment">:nodoc:
</span>    <span class="comment-delimiter"># </span><span class="comment">This is the base class Authlogic, where all modules are included.
</span>    <span class="comment-delimiter"># </span><span class="comment">For information on functiionality see the various sub modules.
</span>    <span class="keyword">class</span> <span class="type">Base</span>
      include <span class="type">Foundation</span>
      include <span class="type">Callbacks</span>

      <span class="comment-delimiter"># </span><span class="comment">Included first so that the session resets itself to nil
</span>      include <span class="type">Timeout</span>

      <span class="comment-delimiter"># </span><span class="comment">Included in a specific order so they are tried in this order when persisting
</span>      include <span class="type">Params</span>
      include <span class="type">Cookies</span>
      include <span class="type">Session</span>
      include <span class="type">HttpAuth</span>

      <span class="comment-delimiter"># </span><span class="comment">Included in a specific order so magic states gets ran after a record is found
</span>      include <span class="type">Password</span>
      include <span class="type">UnauthorizedRecord</span>
      include <span class="type">MagicStates</span>

      include <span class="type">Activation</span>
      include <span class="type">ActiveRecordTrickery</span>
      include <span class="type">BruteForceProtection</span>
      include <span class="type">Existence</span>
      include <span class="type">Klass</span>
      include <span class="type">MagicColumns</span>
      include <span class="type">PerishableToken</span>
      include <span class="type">Persistence</span>
      include <span class="type">Scopes</span>
      include <span class="type">Id</span>
      include <span class="type">Validation</span>
      include <span class="type">PriorityRecord</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
## Object Composition
### (✿ ♥‿♥)

!SLIDE
<pre>
<span class="keyword">class</span> <span class="type">Lamp</span>
  <span class="keyword">def</span> <span class="function-name">initialize</span>(bulb_age)
    <span class="variable-name">@bulb_age</span> = bulb_age
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">needs_maintenance?</span>
    <span class="variable-name">@bulb_age</span> &gt; 2
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre>
<span class="keyword">class</span> <span class="type">Lamp</span>
  <span class="keyword">def</span> <span class="function-name">initialize</span>(bulb_age)
    <span class="variable-name">@bulb_age</span> = bulb_age
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">needs_maintenance?</span>
    <b><span class="variable-name">@bulb_age</span> &gt; 2</b>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre>
<span class="keyword">class</span> <span class="type">Lamp</span>
  <span class="keyword">def</span> <span class="function-name">initialize</span>(bulb)
    <span class="variable-name">@bulb</span> = bulb
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">needs_maintenance?</span>
    <b><span class="variable-name">@bulb</span>.needs_maintenance?</b>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>


!SLIDE
## Middlethangs

!SLIDE
# Rack Middleware

!SLIDE
### Python Web Server Gateway Interface v1.0

python.org/dev/peps/pep-0333/

!SLIDE
## Request Processing

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   use <span class="type">Middleware</span>::<span class="type">Example</span>
   use <span class="type">Rack</span>::<span class="type">CommonLogger</span>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   use <span class="type">Middleware</span>::<span class="type">Example</span>
   use <span class="type">Rack</span>::<span class="type">CommonLogger</span>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>
<span class="right-arrow">↓</span>

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   <b>use <span class="type">Middleware</span>::<span class="type">Example</span></b>
   use <span class="type">Rack</span>::<span class="type">CommonLogger</span>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>
<span class="right-arrow">↓</span>

!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <span class="variable-name">@app</span> = app
    <span class="keyword">end</span>

    <span class="keyword">def</span> <span class="function-name">call</span>(env)
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <span class="variable-name">@app</span>.call(env)

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <b><span class="variable-name">@app</span> = app</b>
    <span class="keyword">end</span>

    <span class="keyword">def</span> <span class="function-name">call</span>(env)
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <span class="variable-name">@app</span>.call(env)

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <span class="variable-name">@app</span> = app
    <span class="keyword">end</span>

    <span class="keyword">def</span> <span class="function-name">call</span>(env)
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <b><span class="variable-name">@app</span>.call(env)</b>

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   use <span class="type">Middleware</span>::<span class="type">Example</span>
   <b>use <span class="type">Rack</span>::<span class="type">CommonLogger</span></b>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>


!SLIDE
<pre>
<span class="type">Rack</span>::<span class="type">Handler</span>::<span class="type">Puma</span>.run(app)
</pre>

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   use <span class="type">Middleware</span>::<span class="type">Example</span>
   use <span class="type">Rack</span>::<span class="type">CommonLogger</span>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>
<span class="right-arrow">↓</span>

!SLIDE
<pre>
app = <span class="type">Rack</span>::<span class="type">Builder</span>.new <span class="keyword">do</span>
   <b>use <span class="type">Middleware</span>::<span class="type">Example</span></b>
   use <span class="type">Rack</span>::<span class="type">CommonLogger</span>
   use <span class="type">Rack</span>::<span class="type">ShowExceptions</span>
<span class="keyword">end</span></pre>
<span class="right-arrow">↓</span>

!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <span class="variable-name">@app</span> = app
    <span class="keyword">end</span>

    <span class="keyword">def</span> <b><span class="function-name">call</span>(env)</b>
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <span class="variable-name">@app</span>.call(env)

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>


!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <span class="variable-name">@app</span> = app
    <span class="keyword">end</span>

    <span class="keyword">def</span> <span class="function-name">call</span>(<b>env</b>)
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <span class="variable-name">@app</span>.call(<b>env</b>)

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>


!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Middleware</span>
  <span class="keyword">class</span> <span class="type">Example</span>
    <span class="keyword">def</span> <span class="function-name">initialize</span>(app)
      <span class="variable-name">@app</span> = app
    <span class="keyword">end</span>

    <span class="keyword">def</span> <span class="function-name">call</span>(env)
      <span class="comment-delimiter"># </span><span class="comment">do something before the next middleware
</span>      <span class="comment-delimiter"># </span><span class="comment">possibly modify the environment
</span>
      <span class="comment-delimiter"># </span><span class="comment">run the next middleware in the stack
</span>      <b><span class="variable-name">@app</span>.call(env)</b>

      <span class="comment-delimiter"># </span><span class="comment">do something after the next middleware
</span>    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE link
# Vagrant
vagrantup.com

!SLIDE
## Virtual Machines

!SLIDE
### `$ vagrant up`

!SLIDE
<pre class="xlarge">
    <span class="type">Builder</span>.new <span class="keyword">do</span>
      use <span class="type">General</span>::<span class="type">Validate</span>
      use <span class="type">VM</span>::<span class="type">CheckAccessible</span>
      use <span class="type">VM</span>::<span class="type">CheckBox</span>
      use <span class="type">VM</span>::<span class="type">Import</span>
      use <span class="type">VM</span>::<span class="type">CheckGuestAdditions</span>
      use <span class="type">VM</span>::<span class="type">MatchMACAddress</span>
      use <span class="type">VM</span>::<span class="type">CheckAccessible</span>
      use <span class="type">VM</span>::<span class="type">CleanMachineFolder</span>
      use <span class="type">VM</span>::<span class="type">ClearForwardedPorts</span>
      use <span class="type">VM</span>::<span class="type">CheckPortCollisions</span>
      use <span class="type">VM</span>::<span class="type">ForwardPorts</span>
      use <span class="type">VM</span>::<span class="type">Provision</span>
      use <span class="type">VM</span>::<span class="type">NFS</span>
      use <span class="type">VM</span>::<span class="type">ClearSharedFolders</span>
      use <span class="type">VM</span>::<span class="type">ShareFolders</span>
      use <span class="type">VM</span>::<span class="type">HostName</span>
      use <span class="type">VM</span>::<span class="type">ClearNetworkInterfaces</span>
      use <span class="type">VM</span>::<span class="type">Network</span>
      use <span class="type">VM</span>::<span class="type">Customize</span>
      use <span class="type">VM</span>::<span class="type">Boot</span>
    <span class="keyword">end</span>
</pre>

!SLIDE
## Virtual Machine Class
### ε(´סּ︵סּ`)з

!SLIDE
## Middleware

!SLIDE
<pre class="large">
<span class="keyword">module</span> <span class="type">Vagrant</span>
  <span class="keyword">module</span> <span class="type">Action</span>
    <span class="keyword">module</span> <span class="type">VM</span>
      <span class="keyword">class</span> <span class="type">Halt</span>
        <span class="keyword">def</span> <span class="function-name">initialize</span>(app, env)
          <span class="variable-name">@app</span> = app
        <span class="keyword">end</span>

        <span class="keyword">def</span> <span class="function-name">call</span>(env)
          env[<span class="constant">:vm</span>].guest.halt
          <span class="variable-name">@app</span>.call(env)
        <span class="keyword">end</span>
      <span class="keyword">end</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE bullets
### Wins
* more general
* familiar mechanics
* recover

!SLIDE bullets
### Issues
* dependencies
* env dumping ground

!SLIDE
# Diaspora User

!SLIDE
<pre class="extreme">
<span class="keyword">class</span> <span class="type">User</span> &lt; <span class="type">ActiveRecord</span>::<span class="type">Base</span>
  include <span class="type">Diaspora</span>::<span class="type">UserModules</span>
  include <span class="type">Encryptor</span>::<span class="type">Private</span>


  <span class="keyword">def</span> <span class="function-name">self.all_sharing_with_person</span>(person)
    <span class="type">User</span>.joins(<span class="constant">:contacts</span>).where(<span class="constant">:contacts</span> =&gt; {<span class="constant">:person_id</span> =&gt; person.id})
  <span class="keyword">end</span>

  <span class="comment-delimiter"># </span><span class="comment">@return [User]
</span>  <span class="keyword">def</span> <span class="function-name">self.find_by_invitation</span>(invitation)
    service = invitation.service
    identifier = invitation.identifier

    <span class="keyword">if</span> service == <span class="string">'email'</span>
      existing_user = <span class="type">User</span>.where(<span class="constant">:email</span> =&gt; identifier).first
    <span class="keyword">else</span>
      existing_user = <span class="type">User</span>.joins(<span class="constant">:services</span>).where(<span class="constant">:services</span> =&gt; {<span class="constant">:type</span> =&gt; <span class="string">"Services::</span><span class="variable-name">#{service.titleize}</span><span class="string">"</span>, <span class="constant">:uid</span> =&gt; identifier}).first
    <span class="keyword">end</span>

   <span class="keyword">if</span> existing_user.nil?
    i = <span class="type">Invitation</span>.where(<span class="constant">:service</span> =&gt; service, <span class="constant">:identifier</span> =&gt; identifier).first
    existing_user = i.recipient <span class="keyword">if</span> i
   <span class="keyword">end</span>

   existing_user
  <span class="keyword">end</span>

  <span class="comment-delimiter"># </span><span class="comment">@return [User]
</span>  <span class="keyword">def</span> <span class="function-name">self.find_or_create_by_invitation</span>(invitation)
    <span class="keyword">if</span> existing_user = <span class="variable-name">self</span>.find_by_invitation(invitation)
      existing_user
    <span class="keyword">else</span>
     <span class="variable-name">self</span>.create_from_invitation!(invitation)
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  # ... to be continued ...
  </pre>

!SLIDE
<pre class="extreme">
  <span class="keyword">def</span> <span class="function-name">self.create_from_invitation!</span>(invitation)
    user = <span class="type">User</span>.new
    user.generate_keys
    user.send(<span class="constant">:generate_invitation_token</span>)
    user.email = invitation.identifier <span class="keyword">if</span> invitation.service == <span class="string">'email'</span>
    <span class="comment-delimiter"># </span><span class="comment">we need to make a custom validator here to make this safer
</span>    user.save(<span class="constant">:validate</span> =&gt; <span class="variable-name">false</span>)
    user
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">send_reset_password_instructions</span>
    generate_reset_password_token! <span class="keyword">if</span> should_generate_token?
    <span class="type">Resque</span>.enqueue(<span class="type">Jobs</span>::<span class="type">ResetPassword</span>, <span class="variable-name">self</span>.id)
  <span class="keyword">end</span>


  <span class="keyword">def</span> <span class="function-name">update_user_preferences</span>(pref_hash)
    <span class="keyword">if</span> <span class="variable-name">self</span>.disable_mail
      <span class="type">UserPreference</span>::<span class="type">VALID_EMAIL_TYPES</span>.each{|x| <span class="variable-name">self</span>.user_preferences.find_or_create_by_email_type(x)}
      <span class="variable-name">self</span>.disable_mail = <span class="variable-name">false</span>
      <span class="variable-name">self</span>.save
    <span class="keyword">end</span>

    pref_hash.keys.each <span class="keyword">do</span> |key|
      <span class="keyword">if</span> pref_hash[key] == <span class="string">'true'</span>
        <span class="variable-name">self</span>.user_preferences.find_or_create_by_email_type(key)
      <span class="keyword">else</span>
        block = <span class="variable-name">self</span>.user_preferences.where(<span class="constant">:email_type</span> =&gt; key).first
        <span class="keyword">if</span> block
          block.destroy
        <span class="keyword">end</span>
      <span class="keyword">end</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">strip_and_downcase_username</span>
    <span class="keyword">if</span> username.present?
      username.strip!
      username.downcase!
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  # ... to be continued ...
  </pre>

!SLIDE
<pre class="extreme">

  <span class="keyword">def</span> <span class="function-name">set_current_language</span>
    <span class="variable-name">self</span>.language = <span class="type">I18n</span>.locale.to_s <span class="keyword">if</span> <span class="variable-name">self</span>.language.blank?
  <span class="keyword">end</span>

  <span class="comment-delimiter"># </span><span class="comment">This override allows a user to enter either their email address or their username into the username field.
</span>  <span class="comment-delimiter"># </span><span class="comment">@return [User] The user that matches the username/email condition.
</span>  <span class="comment-delimiter"># </span><span class="comment">@return [nil] if no user matches that condition.
</span>  <span class="keyword">def</span> <span class="function-name">self.find_for_database_authentication</span>(conditions={})
    conditions = conditions.dup
    conditions[<span class="constant">:username</span>] = conditions[<span class="constant">:username</span>].downcase
    <span class="keyword">if</span> conditions[<span class="constant">:username</span>] =~ <span class="string">/^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/</span>i <span class="comment-delimiter"># </span><span class="comment">email regex
</span>      conditions[<span class="constant">:email</span>] = conditions.delete(<span class="constant">:username</span>)
    <span class="keyword">end</span>
    where(conditions).first
  <span class="keyword">end</span>

  <span class="comment-delimiter"># </span><span class="comment">@param [Person] person
</span>  <span class="comment-delimiter"># </span><span class="comment">@return [Boolean] whether this user can add person as a contact.
</span>  <span class="keyword">def</span> <span class="function-name">can_add?</span>(person)
    <span class="keyword">return</span> <span class="variable-name">false</span> <span class="keyword">if</span> <span class="variable-name">self</span>.person == person
    <span class="keyword">return</span> <span class="variable-name">false</span> <span class="keyword">if</span> <span class="variable-name">self</span>.contact_for(person).present?
    <span class="variable-name">true</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">confirm_email</span>(token)
    <span class="keyword">return</span> <span class="variable-name">false</span> <span class="keyword">if</span> token.blank? || token != confirm_email_token
    <span class="variable-name">self</span>.email = unconfirmed_email
    save
  <span class="keyword">end</span>

  <span class="comment-delimiter">######### </span><span class="comment">Aspects ######################
</span>
  <span class="keyword">def</span> <span class="function-name">move_contact</span>(person, to_aspect, from_aspect)
    <span class="keyword">return</span> <span class="variable-name">true</span> <span class="keyword">if</span> to_aspect == from_aspect
    contact = contact_for(person)

    add_contact_to_aspect(contact, to_aspect)

    membership = contact ? <span class="type">AspectMembership</span>.where(<span class="constant">:contact_id</span> =&gt; contact.id, <span class="constant">:aspect_id</span> =&gt; from_aspect.id).first : <span class="variable-name">nil</span>
    <span class="keyword">return</span>(membership &amp;&amp; membership.destroy)
  <span class="keyword">end</span>

  # ... to be continued ...
  </pre>

!SLIDE
<pre class="extreme">

  <span class="keyword">def</span> <span class="function-name">add_contact_to_aspect</span>(contact, aspect)
    <span class="keyword">return</span> <span class="variable-name">true</span> <span class="keyword">if</span> <span class="type">AspectMembership</span>.exists?(<span class="constant">:contact_id</span> =&gt; contact.id, <span class="constant">:aspect_id</span> =&gt; aspect.id)
    contact.aspect_memberships.create!(<span class="constant">:aspect</span> =&gt; aspect)
  <span class="keyword">end</span>

  <span class="comment-delimiter">######## </span><span class="comment">Posting ########
</span>  <span class="keyword">def</span> <span class="function-name">build_post</span>(class_name, opts = {})
    opts[<span class="constant">:author</span>] = <span class="variable-name">self</span>.person
    opts[<span class="constant">:diaspora_handle</span>] = opts[<span class="constant">:author</span>].diaspora_handle

    model_class = class_name.to_s.camelize.constantize
    model_class.diaspora_initialize(opts)
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">dispatch_post</span>(post, opts = {})
    additional_people = opts.delete(<span class="constant">:additional_subscribers</span>)
    mailman = <span class="type">Postzord</span>::<span class="type">Dispatcher</span>.build(<span class="variable-name">self</span>, post, <span class="constant">:additional_subscribers</span> =&gt; additional_people)
    mailman.post(opts)
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">update_post</span>(post, post_hash = {})
    <span class="keyword">if</span> <span class="variable-name">self</span>.owns? post
      post.update_attributes(post_hash)
      <span class="type">Postzord</span>::<span class="type">Dispatcher</span>.build(<span class="variable-name">self</span>, post).post
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">notify_if_mentioned</span>(post)
    <span class="keyword">return</span> <span class="keyword">unless</span> <span class="variable-name">self</span>.contact_for(post.author) &amp;&amp; post.respond_to?(<span class="constant">:mentions?</span>)

    post.notify_person(<span class="variable-name">self</span>.person) <span class="keyword">if</span> post.mentions? <span class="variable-name">self</span>.person
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">add_to_streams</span>(post, aspects_to_insert)
    inserted_aspect_ids = aspects_to_insert.map{|x| x.id}

    aspects_to_insert.each <span class="keyword">do</span> |aspect|
      aspect &lt;&lt; post
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  # ... to be continued ...
  </pre>

!SLIDE
<pre class="extreme">

  <span class="keyword">def</span> <span class="function-name">aspects_from_ids</span>(aspect_ids)
    <span class="keyword">if</span> aspect_ids == <span class="string">"all"</span> || aspect_ids == <span class="constant">:all</span>
      <span class="variable-name">self</span>.aspects
    <span class="keyword">else</span>
      aspects.where(<span class="constant">:id</span> =&gt; aspect_ids)
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">salmon</span>(post)
    <span class="type">Salmon</span>::<span class="type">EncryptedSlap</span>.create_by_user_and_activity(<span class="variable-name">self</span>, post.to_diaspora_xml)
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">build_relayable</span>(model, options = {})
    r = model.new(options.merge(<span class="constant">:author_id</span> =&gt; <span class="variable-name">self</span>.person.id))
    r.set_guid
    r.initialize_signatures
    r
  <span class="keyword">end</span>

  <span class="comment-delimiter">######## </span><span class="comment">Commenting  ########
</span>  <span class="keyword">def</span> <span class="function-name">build_comment</span>(options = {})
    build_relayable(<span class="type">Comment</span>, options)
  <span class="keyword">end</span>

  <span class="comment-delimiter">######## </span><span class="comment">Liking  ########
</span>  <span class="keyword">def</span> <span class="function-name">build_like</span>(options = {})
    build_relayable(<span class="type">Like</span>, options)
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">liked?</span>(target)
    <span class="keyword">if</span> target.likes.loaded?
      <span class="keyword">if</span> <span class="variable-name">self</span>.like_for(target)
        <span class="keyword">return</span> <span class="variable-name">true</span>
      <span class="keyword">else</span>
        <span class="keyword">return</span> <span class="variable-name">false</span>
      <span class="keyword">end</span>
    <span class="keyword">else</span>
      <span class="type">Like</span>.exists?(<span class="constant">:author_id</span> =&gt; <span class="variable-name">self</span>.person.id, <span class="constant">:target_type</span> =&gt; target.class.base_class.to_s, <span class="constant">:target_id</span> =&gt; target.id)
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  # ... to be continued ...
  </pre>

!SLIDE
<pre class="extreme">

  <span class="comment-delimiter"># </span><span class="comment">Get the user's like of a post, if there is one.
</span>  <span class="comment-delimiter"># </span><span class="comment">@param [Post] post
</span>  <span class="comment-delimiter"># </span><span class="comment">@return [Like]
</span>  <span class="keyword">def</span> <span class="function-name">like_for</span>(target)
    <span class="keyword">if</span> target.likes.loaded?
      <span class="keyword">return</span> target.likes.detect{ |like| like.author_id == <span class="variable-name">self</span>.person.id }
    <span class="keyword">else</span>
      <span class="keyword">return</span> <span class="type">Like</span>.where(<span class="constant">:author_id</span> =&gt; <span class="variable-name">self</span>.person.id, <span class="constant">:target_type</span> =&gt; target.class.base_class.to_s, <span class="constant">:target_id</span> =&gt; target.id).first
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="comment-delimiter">######### </span><span class="comment">Mailer #######################
</span>  <span class="keyword">def</span> <span class="function-name">mail</span>(job, *args)
    pref = job.to_s.gsub(<span class="string">'Jobs::Mail::'</span>, <span class="string">''</span>).underscore
    <span class="keyword">if</span>(<span class="variable-name">self</span>.disable_mail == <span class="variable-name">false</span> &amp;&amp; !<span class="variable-name">self</span>.user_preferences.exists?(<span class="constant">:email_type</span> =&gt; pref))
      <span class="type">Resque</span>.enqueue(job, *args)
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">mail_confirm_email</span>
    <span class="keyword">return</span> <span class="variable-name">false</span> <span class="keyword">if</span> unconfirmed_email.blank?
    <span class="type">Resque</span>.enqueue(<span class="type">Jobs</span>::<span class="type">Mail</span>::<span class="type">ConfirmEmail</span>, id)
    <span class="variable-name">true</span>
  <span class="keyword">end</span>

  <span class="comment-delimiter">######### </span><span class="comment">Posts and Such ###############
</span>  <span class="keyword">def</span> <span class="function-name">retract</span>(target, opts={})

    # ... redacted ...

    mailman = <b><span class="type">Postzord</span></b>::<span class="type">Dispatcher</span>.build(<span class="variable-name">self</span>, retraction, opts)
    mailman.post

    retraction.perform(<span class="variable-name">self</span>)

    retraction
  <span class="keyword">end</span>

  # ... aaaaand we're done here ...
  </pre>

!SLIDE center
<img src="zord.jpg" style="max-height: 600px"></img>

!SLIDE
### 500+ lines
### ε(´סּ︵סּ`)з

!SLIDE
<h3><code class="large">accept_invitation!</code></h3>

!SLIDE
<pre class="xxlarge">
  <span class="keyword">def</span> <span class="function-name">accept_invitation!</span>(opts = {})
    log_hash = {
      <span class="constant">:event</span> =&gt; <span class="constant">:invitation_accepted</span>,
      <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
      <span class="constant">:uid</span> =&gt; <span class="variable-name">self</span>.id
    }

    <span class="keyword">if</span> invitations_to_me.first &amp;&amp; invitations_to_me.first.sender
      log_hash[<span class="constant">:inviter</span>] = invitations_to_me.first.sender.diaspora_handle
    <span class="keyword">end</span>

    <span class="keyword">if</span> <span class="variable-name">self</span>.invited?
      <span class="variable-name">self</span>.setup(opts)
      <span class="variable-name">self</span>.invitation_token = <span class="variable-name">nil</span>
      <span class="variable-name">self</span>.password              = opts[<span class="constant">:password</span>]
      <span class="variable-name">self</span>.password_confirmation = opts[<span class="constant">:password_confirmation</span>]

      <span class="variable-name">self</span>.save
      <span class="keyword">return</span> <span class="keyword">unless</span> <span class="variable-name">self</span>.errors.empty?

      <span class="comment-delimiter"># </span><span class="comment">moved old Invitation#share_with! logic into here,
</span>      <span class="comment-delimiter"># </span><span class="comment">but i don't think we want to destroy the invitation
</span>      <span class="comment-delimiter"># </span><span class="comment">anymore.  we may want to just call self.share_with
</span>      invitations_to_me.each <span class="keyword">do</span> |invitation|
        <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(<span class="variable-name">self</span>.person, invitation.aspect)
          invitation.destroy
        <span class="keyword">end</span>
      <span class="keyword">end</span>

      log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
      <span class="type">Rails</span>.logger.info(log_hash)
      <span class="variable-name">self</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="xxlarge">
  <span class="keyword">def</span> <span class="function-name">accept_invitation!</span>(opts = {})
    log_hash = {
      <span class="constant">:event</span> =&gt; <span class="constant">:invitation_accepted</span>,
      <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
      <span class="constant">:uid</span> =&gt; <span class="variable-name">self</span>.id
    }

    <span class="keyword">if</span> invitations_to_me.first &amp;&amp; invitations_to_me.first.sender
      log_hash[<span class="constant">:inviter</span>] = invitations_to_me.first.sender.diaspora_handle
    <span class="keyword">end</span>

    <span class="keyword">if</span> <span class="variable-name">self</span>.invited?
      <b><span class="variable-name">self</span>.setup(opts)</b>
      <span class="variable-name">self</span>.invitation_token = <span class="variable-name">nil</span>
      <span class="variable-name">self</span>.password              = opts[<span class="constant">:password</span>]
      <span class="variable-name">self</span>.password_confirmation = opts[<span class="constant">:password_confirmation</span>]

      <span class="variable-name">self</span>.save
      <span class="keyword">return</span> <span class="keyword">unless</span> <span class="variable-name">self</span>.errors.empty?

      <span class="comment-delimiter"># </span><span class="comment">moved old Invitation#share_with! logic into here,
</span>      <span class="comment-delimiter"># </span><span class="comment">but i don't think we want to destroy the invitation
</span>      <span class="comment-delimiter"># </span><span class="comment">anymore.  we may want to just call self.share_with
</span>      invitations_to_me.each <span class="keyword">do</span> |invitation|
        <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(<span class="variable-name">self</span>.person, invitation.aspect)
          invitation.destroy
        <span class="keyword">end</span>
      <span class="keyword">end</span>

      log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
      <span class="type">Rails</span>.logger.info(log_hash)
      <span class="variable-name">self</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="large">
  <span class="keyword">def</span> <span class="function-name">setup</span>(opts)
    <span class="variable-name">self</span>.username = opts[<span class="constant">:username</span>]
    <span class="variable-name">self</span>.email = opts[<span class="constant">:email</span>]
    <span class="variable-name">self</span>.language = opts[<span class="constant">:language</span>]
    <span class="variable-name">self</span>.language ||= <span class="type">I18n</span>.locale.to_s
    <span class="variable-name">self</span>.valid?
    errors = <span class="variable-name">self</span>.errors
    errors.delete <span class="constant">:person</span>
    <span class="keyword">return</span> <span class="keyword">if</span> errors.size &gt; 0
    <span class="variable-name">self</span>.set_person(<span class="type">Person</span>.new)
    <span class="variable-name">self</span>.generate_keys
    <span class="variable-name">self</span>
  <span class="keyword">end</span>
</pre>


!SLIDE
### Middlewareified

!SLIDE
<pre class="xxlarge">
        <span class="keyword">def</span> <span class="function-name">call</span>(env)
          <span class="variable-name">@user</span> = env[<span class="constant">:user</span>]
          opts = env[<span class="constant">:opts</span>]

          log_hash = {
            <span class="constant">:event</span>    =&gt; <span class="constant">:invitation_accepted</span>,
            <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
            <span class="constant">:uid</span>      =&gt; user.id
          }

          <span class="keyword">if</span> user.invitations_to_me.first &amp;&amp; user.invitations_to_me.first.sender
            log_hash[<span class="constant">:inviter</span>] = user.invitations_to_me.first.sender.diaspora_handle
          <span class="keyword">end</span>

          <span class="keyword">if</span> user.invited?
            user.setup(opts)
            user.invitation_token      = <span class="variable-name">nil</span>
            user.password              = opts[<span class="constant">:password</span>]
            user.password_confirmation = opts[<span class="constant">:password_confirmation</span>]
            user.save

            <span class="keyword">return</span> <span class="keyword">unless</span> user.errors.empty?

            user.invitations_to_me.each <span class="keyword">do</span> |invitation|
              <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(user.person, invitation.aspect)
                invitation.destroy
              <span class="keyword">end</span>
            <span class="keyword">end</span>

            log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
            <span class="type">Rails</span>.logger.info(log_hash)
            user
          <span class="keyword">end</span>

          <span class="comment-delimiter"># </span><span class="comment">call the next middleware
</span>          <span class="variable-name">@app</span>.call
        <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="xxlarge">
        <span class="keyword">def</span> <span class="function-name">call</span>(env)
          <b><span class="variable-name">@user</span> = env[<span class="constant">:user</span>]</b>
          <b>opts = env[<span class="constant">:opts</span>]</b>

          log_hash = {
            <span class="constant">:event</span>    =&gt; <span class="constant">:invitation_accepted</span>,
            <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
            <span class="constant">:uid</span>      =&gt; user.id
          }

          <span class="keyword">if</span> user.invitations_to_me.first &amp;&amp; user.invitations_to_me.first.sender
            log_hash[<span class="constant">:inviter</span>] = user.invitations_to_me.first.sender.diaspora_handle
          <span class="keyword">end</span>

          <span class="keyword">if</span> user.invited?
            user.setup(opts)
            user.invitation_token      = <span class="variable-name">nil</span>
            user.password              = opts[<span class="constant">:password</span>]
            user.password_confirmation = opts[<span class="constant">:password_confirmation</span>]
            user.save

            <span class="keyword">return</span> <span class="keyword">unless</span> user.errors.empty?

            user.invitations_to_me.each <span class="keyword">do</span> |invitation|
              <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(user.person, invitation.aspect)
                invitation.destroy
              <span class="keyword">end</span>
            <span class="keyword">end</span>

            log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
            <span class="type">Rails</span>.logger.info(log_hash)
            user
          <span class="keyword">end</span>

          <span class="comment-delimiter"># </span><span class="comment">call the next middleware
</span>          <span class="variable-name">@app</span>.call
        <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="xxlarge">
        <span class="keyword">def</span> <span class="function-name">call</span>(env)
          <span class="variable-name">@user</span> = env[<span class="constant">:user</span>]
          opts = env[<span class="constant">:opts</span>]

          log_hash = {
            <span class="constant">:event</span>    =&gt; <span class="constant">:invitation_accepted</span>,
            <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
            <span class="constant">:uid</span>      =&gt; <b>user</b>.id
          }

          <span class="keyword">if</span> <b>user</b>.invitations_to_me.first &amp;&amp; <b>user</b>.invitations_to_me.first.sender
            log_hash[<span class="constant">:inviter</span>] = <b>user</b>.invitations_to_me.first.sender.diaspora_handle
          <span class="keyword">end</span>

          <span class="keyword">if</span> <b>user</b>.invited?
            <b>user</b>.setup(opts)
            <b>user</b>.invitation_token      = <span class="variable-name">nil</span>
            <b>user</b>.password              = opts[<span class="constant">:password</span>]
            <b>user</b>.password_confirmation = opts[<span class="constant">:password_confirmation</span>]
            <b>user</b>.save

            <span class="keyword">return</span> <span class="keyword">unless</span> <b>user</b>.errors.empty?

            <b>user</b>.invitations_to_me.each <span class="keyword">do</span> |invitation|
              <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(<b>user</b>.person, invitation.aspect)
                invitation.destroy
              <span class="keyword">end</span>
            <span class="keyword">end</span>

            log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
            <span class="type">Rails</span>.logger.info(log_hash)
            user
          <span class="keyword">end</span>

          <span class="comment-delimiter"># </span><span class="comment">call the next middleware
</span>          <span class="variable-name">@app</span>.call
        <span class="keyword">end</span>
</pre>
!SLIDE
<pre class="xxlarge">
        <span class="keyword">def</span> <span class="function-name">call</span>(env)
          <span class="variable-name">@user</span> = env[<span class="constant">:user</span>]
          opts = env[<span class="constant">:opts</span>]

          log_hash = {
            <span class="constant">:event</span>    =&gt; <span class="constant">:invitation_accepted</span>,
            <span class="constant">:username</span> =&gt; opts[<span class="constant">:username</span>],
            <span class="constant">:uid</span>      =&gt; user.id
          }

          <span class="keyword">if</span> user.invitations_to_me.first &amp;&amp; user.invitations_to_me.first.sender
            log_hash[<span class="constant">:inviter</span>] = user.invitations_to_me.first.sender.diaspora_handle
          <span class="keyword">end</span>

          <span class="keyword">if</span> user.invited?
            user.setup(opts)
            user.invitation_token      = <span class="variable-name">nil</span>
            user.password              = opts[<span class="constant">:password</span>]
            user.password_confirmation = opts[<span class="constant">:password_confirmation</span>]
            user.save

            <span class="keyword">return</span> <span class="keyword">unless</span> user.errors.empty?

            user.invitations_to_me.each <span class="keyword">do</span> |invitation|
              <span class="keyword">if</span> !invitation.admin? &amp;&amp; invitation.sender.share_with(user.person, invitation.aspect)
                invitation.destroy
              <span class="keyword">end</span>
            <span class="keyword">end</span>

            log_hash[<span class="constant">:status</span>] = <span class="string">"success"</span>
            <span class="type">Rails</span>.logger.info(log_hash)
            user
          <span class="keyword">end</span>

          <span class="comment-delimiter"># </span><span class="comment">call the next middleware
</span>          <b><span class="variable-name">@app</span>.call</b>
        <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="large">
    <span class="keyword">def</span> <span class="function-name">setup</span>(opts)
      user.username    = opts[<span class="constant">:username</span>]
      user.email       = opts[<span class="constant">:email</span>]
      user.language    = opts[<span class="constant">:language</span>]
      user.language || = <span class="type">I18n</span>.locale.to_s
      user.valid?
      errors = user.errors
      errors.delete <span class="constant">:person</span>
      <span class="keyword">return</span> <span class="keyword">if</span> errors.size &gt; 0
      user.set_person(<span class="type">Person</span>.new(opts[<span class="constant">:person</span>] || {} ))
      user.generate_keys
    <span class="keyword">end</span>
</pre>

!SLIDE
<pre class="large">
    <span class="keyword">def</span> <span class="function-name">setup</span>(opts)
      <b>user</b>.username    = opts[<span class="constant">:username</span>]
      <b>user</b>.email       = opts[<span class="constant">:email</span>]
      <b>user</b>.language    = opts[<span class="constant">:language</span>]
      <b>user</b>.language || = <span class="type">I18n</span>.locale.to_s
      <b>user</b>.valid?
      errors = <b>user</b>.errors
      errors.delete <span class="constant">:person</span>
      <span class="keyword">return</span> <span class="keyword">if</span> errors.size &gt; 0
      <b>user</b>.set_person(<span class="type">Person</span>.new(opts[<span class="constant">:person</span>] || {} ))
      <b>user</b>.generate_keys
    <span class="keyword">end</span>
</pre>

!SLIDE
<pre style="font-size: 1.9em">
<span class="keyword">class</span> <span class="type">InvitationsController</span> &lt; <span class="type">Devise</span>::<span class="type">InvitationsController</span>
  <span class="keyword">def</span> <span class="function-name">update</span>
    <span class="comment-delimiter"># </span><span class="comment">... redacted ...
</span>
    user = <span class="type">User</span>.find_by_invitation_token!(invitation_token)

    user.accept_invitation!(params[<span class="constant">:user</span>])

    <span class="comment-delimiter"># </span><span class="comment">... redacted ...
</span>  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

!SLIDE
<pre style="font-size: 2em">
<span class="keyword">class</span> <span class="type">User</span> &lt; <span class="type">ActiveRecord</span>::<span class="type">Base</span>
  <span class="keyword">def</span> <span class="function-name">accept_invitation!</span>(opts = {})
    accept = <span class="type">Middleware</span>::<span class="type">AcceptInvitation</span>.new(lambda {})
    accept.call(opts.merge(<span class="constant">:user</span> =&gt; user))

    <span class="comment-delimiter"># </span><span class="comment">or
</span>
    run(<span class="constant">:accept_invitation</span>, opts.merge(<span class="constant">:user</span> =&gt; user))
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>


!SLIDE
# Wrap Up

!SLIDE bullets
### Delegates?
* moving code around
* more state storage
* entry point ambiguity

!SLIDE
## Real Wins

!SLIDE
### Serial Method Invocation

!SLIDE
<pre>
    <span class="keyword">def</span> <span class="function-name">foo</span>
      bar(1)
      baz(1, 2)
      bak(<span class="string">"fing"</span>)
    <span class="keyword">end</span>
</pre>

!SLIDE
<pre>
    stack = <span class="type">Builder</span>.new <span class="keyword">do</span>
      use <span class="type">Bar</span>
      use <span class="type">Baz</span>
      use <span class="type">Bak</span>
    <span class="keyword">end</span>

    stack.call( 1, 1, 2, <span class="string">"fing"</span>)
</pre>

!SLIDE
### Function Composition

!SLIDE
<pre>
    <span class="keyword">def</span> <span class="function-name">foo</span>
      bar(baz(bak(<span class="string">"fing"</span>)))
    <span class="keyword">end</span>
</pre>

!SLIDE
<pre>
    stack = <span class="type">Builder</span>.new <span class="keyword">do</span>
      use <span class="type">Bak</span>
      use <span class="type">Baz</span>
      use <span class="type">Bar</span>
    <span class="keyword">end</span>

    stack.call(<span class="string">"fing"</span>)
</pre>

!SLIDE
<pre>
    stack = <span class="type">Builder</span>.new <span class="keyword">do</span>
      <b>use <span class="type">Bak</span></b>
      <b>use <span class="type">Baz</span></b>
      <b>use <span class="type">Bar</span></b>
    <span class="keyword">end</span>

    stack.call(<span class="string">"fing"</span>)
</pre>

!SLIDE bullets mono-bullets thanks
## Thanks!
* @johnbender
* johnbender.us
* github.com/johnbender

