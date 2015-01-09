$(function(){ //DOM Ready
    
    //Call functions
    toggleNav();
    toggleItemMenu();
    setFilterItems();
    toggleLoadingStatus();
    toggleUploadNav();
    setActiveOnExternalClick();
    setItemActive();
    setSearchbarWidth();
    
    if($('#files_wrapper').length > 0){
        setFilesItemID();
        setViewType();
    }else{};
    
    if($('#help_categorie_wrapper').length > 0){
        setHelpItems();
    }else{}
    
    //Toggle Upload navigation
    function toggleUploadNav(){
        
        //Upload button
        var upload_button       = $('#upload_button_main');
        
        //Upload popup root
        var upload_root_node    = $('#upload-popup');
        
        //Nav items
        var file_upload_tab     = $('#file_upload_button');
        var contact_upload_tab  = $('#contact_upload_button');
        
        //Content items
        var file_upload_form    = $('#upload_files_form_wrapper');
        var contact_upload_form = $('#upload_contact_form_wrapper');
        
        upload_button.on("click", function(e){
            
            file_upload_tab.addClass('active');
            contact_upload_tab.removeClass('active');
            
            file_upload_form.addClass('active');
            contact_upload_form.removeClass('active');
            
        });
        
        file_upload_tab.on("click", function(e){
            
            file_upload_tab.addClass('active');
            contact_upload_tab.removeClass('active');
            
            file_upload_form.addClass('active');
            contact_upload_form.removeClass('active');
            
        });
        
        contact_upload_tab.on("click", function(e){
            
            contact_upload_tab.addClass('active');
            file_upload_tab.removeClass('active');
            
            contact_upload_form.addClass('active');
            file_upload_form.removeClass('active');
        
        });
        
    }
    
    //
    function setActiveOnExternalClick(){
        
        //Share root node
        var share_root_node     = $('#share_popup');
        
        //Upload popup root
        var upload_root_node    = $('#upload-popup');
        
        //Nav items
        var file_upload_tab     = $('#file_upload_button');
        var contact_upload_tab  = $('#contact_upload_button');
        
        //Content items
        var file_upload_form    = $('#upload_files_form_wrapper');
        var contact_upload_form = $('#upload_contact_form_wrapper');
        
        //Add contact button
        var add_contact_button  = $('#add_contact_button_external');
        
        add_contact_button.on("click", function(e){
            
            console.log("click");
        
            contact_upload_tab.addClass('active');
            file_upload_tab.removeClass('active');
            
            contact_upload_form.addClass('active');
            file_upload_form.removeClass('active');
            
        });
        
    }
    
    //Toggle sidebar slideouts
    function toggleNav(){
        
        $('.sidebar-filter-trigger').on("click", function (e) { 
            
            var sidebarsub_node = $('.sidebar-filter');
            
            sidebarsub_node.slideToggle();
        });
    }
    
    //Set the correct ID on the menu buttons
    function setFilesItemID(){
        
        var files_root_node = $('#file_blocks');       
        var items_list      = files_root_node.children('.file_item');

        items_list.each(function(index){

            $(this).find('img.share_button').attr('id', 'share_button' + $(this).attr('id'));
            $(this).find('img.detail_button').attr('onclick', 'setDetailInfo(' + "'" + $(this).attr('id') + "'" + ')');
            $(this).find('img.edit_button').attr('onclick', 'setEdit(' + "'" + $(this).attr('id') + "'" + ')');
            $(this).find('img.delete_button').attr('onclick', 'setDelete(' + "'" + $(this).attr('id') + "'" + ')');
        });
    }
    
    //Dynamic counter for help items
    function setHelpItems(){
        
        var help_categorie_root_node    = $('#help_categorie_wrapper');
        var help_detail_root_node       = $('#help_detail_wrapper');
        
        var help_categorie_nodes        = help_categorie_root_node.find('div.help_categorie_item');
        var help_detail_nodes           = help_detail_root_node.find('div.help_detail');
        
        //Set ID Categorie
        help_categorie_nodes.each(function(index){
            $(this).attr('id', 'help_categorie_' + index);
        });
        
        //Set ID Detail
        help_detail_nodes.each(function(index){
            $(this).attr('id', 'help_detail_' + index);
        });
        
        //Set Click
        help_categorie_nodes.on("click", function(e){
            
            help_detail_nodes.css("display", "none");
            
            var itemID      = $(this).attr('id');
            var itemIndex   = itemID.substr(itemID.length - 1);
            
            var itemDetail  = "#help_detail_" + itemIndex;
            
            if($(itemDetail).css('display') == "block"){
                $(itemDetail).hide();
            }
            else{
                $(itemDetail).show();
            }
            
        });
        
    }
    
    //Toggle view type
    function setViewType(){
        
        //View types
        var block_view      = $('#file_blocks');
        var list_view       = $('#files_list');
        
        //View buttons
        var block_button    = $('#set_blocks');
        var list_button     = $('#set_list');
        
        if(block_button.hasClass('active')){
            block_button.find('img').attr('src', '/assets/Icons/ic_block_view_active.png');
        }
        
        //For block view
        block_button.on("click", function(e){
            
            block_view.css('display', 'block');
            list_view.css('display', 'none');
            
            block_button.addClass('active');
            block_button.find('img').attr('src', '/assets/Icons/ic_block_view_active.png');
            list_button.find('img').attr('src', '/assets/Icons/ic_list_view_new.png');
            list_button.removeClass('active');
        })
        
        //For list view
        list_button.on("click", function(e){
            
            list_view.css('display', 'block');
            block_view.css('display', 'none');
            
            list_button.addClass('active');
            list_button.find('img').attr('src', '/assets/Icons/ic_list_view_active.png');
            block_button.find('img').attr('src', '/assets/Icons/ic_block_view_new.png');
            block_button.removeClass('active');
        })
    }
    
    
    //Toggle item menu
    function toggleItemMenu(){
     
        $('.thumb_wrap').on("click", function(e){
            
            var item_node       = $(this).parent();
            var file_menu_node  = item_node.find('div.menu');

            //file_menu_node.slideToggle();
            file_menu_node.toggle();

        });
        
        $('.file_item').find('div.file_info').on("click", function(e){

            var item_node       = $(this).parent();
            var file_menu_node  = item_node.find('div.menu');

            //file_menu_node.slideToggle();
            file_menu_node.toggle();

        });
         
    }
    
    //Set filter items
    function setFilterItems(url){
        
        var main_filter_list    = $('.sidebar-filter ul li');
        var filter_button_node  = $('.filter_button a');

        var selected_items      = [];
        
        main_filter_list.on("click", function (e) { 
            
            if($.inArray($(this).text(), selected_items) !== -1){
                selected_items.splice($.inArray($(this).text(), selected_items), 1);
                $(this).attr('class', ' ');
            }
            else{
                selected_items.push($(this).text());
                $(this).attr('class', 'active');
            }
            
            var selected_items_str = selected_items.join([separator = '+']);
            
            filter_button_node.attr('href', '?f=' + selected_items_str);
            
        });
    }
    
    //Toggle loading status 
    function toggleLoadingStatus(){
        
        $('.upload_submit_button').on("click", function(e) {
            
            $('.loading_status').show();
            
        });
        
    }
    
    //Set item active - Contact/Group
    function setItemActive(){
        
        //Root nodes
        var contact_list_node   = $('#contact_sharing_list')
        var group_list_node     = $('#group_sharing_list')
        
        contact_list_node.find('div.contact').on("click", function(e){
        
            if($(this).hasClass('selected')){
                $(this).removeClass('selected');
            }
            else{
                $(this).addClass('selected');
            }
        })
        
        group_list_node.find('div.group').on("click", function(e){
        
            if($(this).hasClass('selected')){
                $(this).removeClass('selected');
            }
            else{
                $(this).addClass('selected');
            }
        })
        
    }
    
    function setSearchbarWidth(){
        
        //Root node
        var searchbar = $('#navbar').find('form.search-form');
        
        searchbar.find('input').focus(function(){
        
            $(this).css('width', '400px');
            
        });
        searchbar.find('input').focusout(function(){
        
            $(this).css('width', '100%');
            
        });
    }
    
});

//Set share information on item click
function setShareInfo(itemTitle, publicLink, privateLink, privateKeys){

    //Information from parameters
    var item_title      = itemTitle;
    var public_link     = publicLink;
    var private_link    = privateLink;
    var private_keys    = privateKeys;
    
    //Root
    var share_popup_node    = $('#share-popup'); 
    
    //Title set
    var title_node          = share_popup_node.find('h1').text('Delen - ' + item_title);
    
    /***** Link Sharing *****/
    //Public link set
    var public_link_node    = share_popup_node.find('div.public_share p a');
    var public_input_node   = share_popup_node.find('div.public_share input');
    
    public_link_node.attr('href', public_link);
    //public_link_node.text(public_link);
    public_input_node.attr('value', public_link);
    
    //Private link set
    var private_link_node   = share_popup_node.find('div.private_share p a');
    var private_input_node  = share_popup_node.find('div.private_share input');
    var private_keys_node   = share_popup_node.find('div.private_share ul');
    
    private_link_node.attr('href', private_link);
    private_input_node.attr('value', private_link);
    //private_link_node.text(private_link);
    
    private_keys_node.empty();
    
    for(var i = 0; i < private_keys.length; i++){
        private_keys_node.append("<li>"+ private_keys[i] +"</li>")
    }
    
    /***** Email Sharing *****/
    var email_link_node     = $('#email_share_link');
    
    email_link_node.attr('value', public_link);

}

//Set Detail information on item click
function setDetailInfo(itemId){
    
    //Get current item
    var item_id         = "#" + itemId 
    var clickedItem     = $(item_id);
    
    var item_title      = clickedItem.find('div.file_title_full').text();
    var item_image      = clickedItem.find('div.thumb img').attr('src');
    var item_date       = clickedItem.find('div.file_date').text();
    var item_descrip    = clickedItem.find('div.file_descrip').text();
    var item_file_url   = clickedItem.find('div.file_full_url').text();
    var item_filetype   = clickedItem.find('div.file_filetype').text();
    
    $('#details_wrapper .detail_info h2').text(item_title);
    
    $('#details_wrapper .detail_popup_date').text(item_date);
    $('#details_wrapper .details_popup_bottom p').text(item_descrip);
    
    //Reset pop-up
    $('#details_wrapper .detail_image').css('display', 'none');
    $('#details_wrapper .detail_other').find('p.download_link').remove();
    
    switch(item_filetype) {
        case 'image':
            $('#details_wrapper .detail_image').css('display', 'block');
            $('#details_wrapper .detail_image img').attr('src', item_image);
            $('#details_wrapper .detail_image img').attr('onclick', 'setFullImage(' + "'" + item_image + "'" + ')');
            break;
        /*case 'audio':
            if($('#details_wrapper .detail_other').css('display') == 'block'){
                console.log('Already set');
            }
            else{
                $('#details_wrapper .detail_other').css('display', 'block');
                $('#details_wrapper .detail_other').append("<audio class='audio_player' controls>" + "<source src=" + item_file_url + " type='audio/mpeg'>" + "Your browser does not support the audio element." + "</audio>");
            }
            break;
        case 'video':
            if($('#details_wrapper .detail_ot her').css('display') == 'block'){
                console.log('Already set');
            }
            else{
                $('#details_wrapper .detail_other').css('display', 'block');
                $('#details_wrapper .detail_other').append("<video width='500' height='240' controls>" + "<source src=" + item_file_url + " type='video/mp4'>" + "Your browser does not support the video element." + "</video>");
            }
            break;
        case 'document':
            if($('#details_wrapper .detail_other').css('display') == 'block'){
                console.log('Already set');
            }
            else{
                $('#details_wrapper .detail_other').css('display', 'block');
                $('#details_wrapper .detail_other').append("<p>" + "<a href='" + item_file_url + "'>" + "Download this file" + "</a>" + "</p>");
            }
            break;*/
        default:
            if($('#details_wrapper .detail_other').css('display') == 'block'){
                console.log('Already set');
            }
            else{
                $('#details_wrapper .detail_other').css('display', 'block');
                $('#details_wrapper .detail_other').append("<p class='download_link'>" + "<a href='" + item_file_url + "'>" + "Download this file" + "</a>" + "</p>");
            }
            break;
    }
}

//Set Edit information on item click
function setEdit(itemId){
    
    var item_id         = "#" + itemId 
    var clickedItem     = $(item_id);
    
    var item_title      = clickedItem.find('div.file_title_full').text();
    var item_descrip    = clickedItem.find('div.file_descrip').text();
    
    //Root
    var edit_popup_node = $('#edit-popup'); 
    
    //Title set
    var title_node      = edit_popup_node.find('h1').text('Aanpassen - ' + item_title);

    console.log(itemId);
    
    //Form set
    edit_popup_node.find('input.edit_id').attr('value', itemId);
    edit_popup_node.find('input.title_edit').attr('value', item_title);
    edit_popup_node.find('textarea.descrip_edit').text(item_descrip);
}

//Set Delete information on item click
function setDelete(itemId){

    var item_id             = "#" + itemId
    var clickedItem         = $(item_id);
    
    var item_title          = clickedItem.find('div.file_title_full').text();
    
    //Root
    var delete_popup_node   = $('#delete-popup'); 
    
    //Title set
    delete_popup_node.find('h1').text('Verwijder - ' + item_title);
    
    //Form set
    delete_popup_node.find('input.delete_id').attr('value', itemId);
    
}

//Set item filetype and detail action
function setDetailType(filetype, itemUrl){
    
    var item_url             = itemUrl;
    
    //Root
    var image_popup_node   = $('#full-img-popup'); 
    
    //Image set
    image_popup_node.find('img').attr('src', img_url);
}

//Set item image for click
function setFullImage(imageUrl){
    
    var image_url             = imageUrl;
    
    //Root
    var image_popup_node   = $('#full-img-popup'); 
    
    //Image set
    image_popup_node.find('img').attr('src', image_url);
}



