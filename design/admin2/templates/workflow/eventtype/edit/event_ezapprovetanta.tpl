<div class="block">

{* Sections *}
<div class="element">
    <label>{'Affected sections'|i18n( 'design/admin/workflow/eventtype/edit' )}:</label>
    <select name="WorkflowEvent_event_ezapprove_section_{$event.id}[]" size="5" multiple="multiple">
    <option value="-1"
         {section show=and( $event.selected_sections|count()|eq( 1 ), $event.selected_sections[0]|eq( '' ) )}
             selected="selected"
         {section-else}
             {if $event.selected_sections|contains( -1 )} selected="selected"{/if}
         {/section}>
    {'All sections'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    {section var=Sections loop=$event.workflow_type.sections}
    <option value="{$Sections.item.value}"{if $event.selected_sections|contains( $Sections.item.value )} selected="selected"{/if}>{$Sections.item.name|wash}</option>
    {/section}
    </select>
</div>

{* Languages *}
<div class="element">
    <label>{'Affected languages'|i18n( 'design/admin/workflow/eventtype/edit' )}:</label>
    <select name="WorkflowEvent_event_ezapprove_languages_{$event.id}[]" size="5" multiple="multiple">
    <option value="-1"
         {if eq( count( $event.language_list ), 0 )}
             selected="selected"
         {/if}>
    {'All languages'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    {section var=Language loop=$event.workflow_type.languages}
    <option value="{$Language.item.id}"{if is_set( $event.language_list[$Language.item.id] )} selected="selected"{/if}>{$Language.item.name|wash}</option>
    {/section}
    </select>
</div>

{* Classes *}
<div class="element">
    <label>{'Classes to run workflow'|i18n( 'design/admin/workflow/eventtype/edit' )}:</label>
    <select name="WorkflowEvent_event_ezapprove_classes_{$event.id}[]" size="5" multiple="multiple">
    <option value="-1"{if $event.selected_classes|contains( -1 )} selected="selected" {/if}>{'All classes'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    {section var=Classes loop=$event.workflow_type.contentclass_list}
    <option value="{$Classes.item.value}"{if $event.selected_classes|contains( $Classes.item.value )} selected="selected"{/if}>{$Classes.item.Name|wash}</option>
    {/section}
    </select>
</div>

{* Affected versions option *}
<div class="element">
    <label>{'Affected versions'|i18n( 'design/admin/workflow/eventtype/edit' )}:</label>
    <select name="WorkflowEvent_event_ezapprove_version_option_{$event.id}[]" size="3" multiple="multiple">
    <option value="0"{if or( lt($event.version_option, 1), gt($event.version_option, 2) )} selected="selected"{/if}>{'All versions'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    <option value="1"{if eq( $event.version_option, 1)} selected="selected"{/if}>{'Publishing new object'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    <option value="2"{if eq( $event.version_option, 2)} selected="selected"{/if}>{'Updating existing object'|i18n( 'design/admin/workflow/eventtype/edit' )}</option>
    </select>
</div>

{* User who functions as approver *}
<div class="block">
<fieldset>
<legend>{'Users who approve content'|i18n( 'design/admin/workflow/eventtype/edit' )}</legend>
{section show=$event.approve_users}
    <table class="list" cellspacing="0">
    <tr>
        <th class="tight">&nbsp;</th>
        <th>{'User'|i18n( 'design/admin/workflow/eventtype/edit' )}</th>
    </tr>
    {section var=User loop=$event.approve_users sequence=array( bglight, bgdark )}
        <tr class="{$User.sequence}">
            <td><input type="checkbox" name="DeleteApproveUserIDArray_{$event.id}[]" value="{$User.item}" />
            <input type="hidden" name="WorkflowEvent_event_user_id_{$event.id}[]" value="{$User.item}" /></td>
            <td>{fetch(content, object, hash( object_id, $User.item)).name|wash}</td>
        </tr>
    {/section}
    </table>
{section-else}
    <p>{'No users selected.'|i18n( 'design/admin/workflow/eventtype/edit' )}</p>
{/section}

<input class="button" type="submit" name="CustomActionButton[{$event.id}_RemoveApproveUsers]" value="{'Remove selected'|i18n( 'design/admin/workflow/eventtype/edit' )}"
       {if $event.approve_users|not}disabled="disabled"{/if} />
<input class="button" type="submit" name="CustomActionButton[{$event.id}_AddApproveUsers]" value="{'Add users'|i18n( 'design/admin/workflow/eventtype/edit' )}" />

</fieldset>
</div>

{* User groups who functions as approver *}
<div class="block">
<fieldset>
<legend>{'Groups who approve content'|i18n( 'design/admin/workflow/eventtype/edit' )}</legend>
{section show=$event.approve_groups}
    <table class="list" cellspacing="0">
    <tr>
        <th class="tight">&nbsp;</th>
        <th>{'Group'|i18n( 'design/admin/workflow/eventtype/edit' )}</th>
    </tr>
    {section var=Group loop=$event.approve_groups sequence=array( bglight, bgdark )}
        <tr class="{$Group.sequence}">
            <td><input type="checkbox" name="DeleteApproveGroupIDArray_{$event.id}[]" value="{$Group.item}" />
            <input type="hidden" name="WorkflowEvent_event_user_id_{$event.id}[]" value="{$Group.item}" /></td>
            <td>{fetch(content, object, hash( object_id, $Group.item)).name|wash}</td>
        </tr>
    {/section}
    </table>
{section-else}
    <p>{'No groups selected.'|i18n( 'design/admin/workflow/eventtype/edit' )}</p>
{/section}

<input class="button" type="submit" name="CustomActionButton[{$event.id}_RemoveApproveGroups]" value="{'Remove selected'|i18n( 'design/admin/workflow/eventtype/edit' )}"
       {if $event.approve_groups|not}disabled="disabled"{/if} />
<input class="button" type="submit" name="CustomActionButton[{$event.id}_AddApproveGroups]" value="{'Add groups'|i18n( 'design/admin/workflow/eventtype/edit' )}" />

</fieldset>
</div>

{* Excluded users & groups *}
<div class="block">
<fieldset>
<legend>{'Excluded user groups ( users in these groups do not need to have their content approved )'|i18n( 'design/admin/workflow/eventtype/edit' )}</legend>
{section show=$event.selected_usergroups}
<table class="list" cellspacing="0">
<tr>
<th class="tight">&nbsp;</th>
<th>{'User and user groups'|i18n( 'design/admin/workflow/eventtype/edit' )}</th>
</tr>
{section var=User loop=$event.selected_usergroups sequence=array( bglight, bgdark )}
<tr class="{$User.sequence}">
<td><input type="checkbox" name="DeleteExcludeUserIDArray_{$event.id}[]" value="{$User.item}" />
    <input type="hidden" name="WorkflowEvent_event_user_id_{$event.id}[]" value="{$User.item}" /></td>
<td>{fetch(content, object, hash( object_id, $User.item)).name|wash}</td>
</tr>
{/section}
</table>
{section-else}
<p>{'No groups selected.'|i18n( 'design/admin/workflow/eventtype/edit' )}</p>
{/section}

<input class="button" type="submit" name="CustomActionButton[{$event.id}_RemoveExcludeUser]" value="{'Remove selected'|i18n( 'design/admin/workflow/eventtype/edit' )}"
       {if $event.selected_usergroups|not}disabled="disabled"{/if} />
<input class="button" type="submit" name="CustomActionButton[{$event.id}_AddExcludeUser]" value="{'Add groups'|i18n( 'design/admin/workflow/eventtype/edit' )}" />

</fieldset>
</div>

</div>
