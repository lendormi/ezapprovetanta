{let approval_content=$collaboration_item.content
     objectversion=fetch( content, version,
                          hash( object_id, $approval_content.content_object_id,
                                version_id, $approval_content.content_object_version ) )}
{set-block scope=root variable=subject}{'[%sitename] "%objectname" awaits approval'
                                        |i18n( "design/standard/collaboration/approval",,
                                               hash( '%sitename', ezini( "SiteSettings", "SiteURL" ),
                                                     '%objectname', $objectversion.version_name|wash ) )}{/set-block}
Este mail va para el creador del objeto cuando se produce un comentario
{'This email is to inform you that "%objectname" awaits approval at %sitename before it can be published.
If you want to send comments to the approver or view the status use the URL below.'
 |i18n( 'design/standard/collaboration/approval',,
        hash( '%sitename', ezini( "SiteSettings", "SiteURL" ),
              '%objectname', $objectversion.version_name|wash ) )}
http://{ezini( "SiteSettings", "SiteURL" )}{concat( "collaboration/item/full/", $collaboration_item.id )|ezurl( no )}

{"If you do not want to continue receiving these notifications,
change your settings at:"|i18n( 'design/standard/notification' )}
http://{ezini( "SiteSettings", "SiteURL" )}{concat( "notification/settings/" )|ezurl( no )}

--
{"%sitename notification system"
 |i18n( 'design/standard/notification',,
        hash( '%sitename', ezini( "SiteSettings", "SiteURL" ) ) )}
{/let}