###
  ExColor for jQuery
  http://excolor.ramiro.mx
###

jQuery.fn.excolor = (C) ->
  C = jQuery.extend(
    hue_bar: 0
    hue_slider: 0
    sb_slider: 0
    color_box: true
    demo_mode: false
    show_color_on_border: false
    border_color: "black"
    sb_border_color: "black"
    anim_speed: "slow"
    round_corners: true
    shadow: true
    shadow_size: 4
    shadow_color: "#8a8a8a"
    background_color: "silver"
    backlight: true
    input_text_color: "black"
    input_background_color: "white"
    label_color: "black"
    effect: "none"
    root_path: false
    rgb_output: false
    callback_on_ok: ->
      a = ""
  , C)
  @each ->
    init_color = ->
      parsex = jQuery.trim(jQuery(aitem).val() + "")
      inputhex = ""
      if parsex is ""
        jQuery(isample).val("").css "background", "url(" + root_path + "transp.gif) repeat"
        jQuery(wrapper).find("input").val ""
      else
        if parsex.match(rgb_input)
          rgb_output = true
          rgbstring = parsergb(parsex)
          inputhex = rgb2hex(rgbstring[0], rgbstring[1], rgbstring[2])
        else
          i = 0

          while i < parsex.length
            inputhex += parsex.charAt(i) + ""  if inputhex.length < 6  if parsex.charAt(i) isnt "#" and (parsex.charAt(i) + "") of y
            i++
          switch inputhex.length
            when 0
              inputhex = "000000" + inputhex
            when 1
              inputhex = "00000" + inputhex
            when 2
              inputhex = "0000" + inputhex
            when 3
              inputhex = "000" + inputhex
            when 4
              inputhex = "00" + inputhex
            when 5
              inputhex = "0" + inputhex
        parsex = hex2rgb(inputhex)
        parsex = rgb2hsv(parsex["r"], parsex["g"], parsex["b"])
        hue = 120 - Math.round(parsex["h"] * 1 / 3)
        hue = 0  if hue < 0
        hue = 119  if hue > 119
        saturation = parsex["s"]
        brightness = parsex["v"]
        jQuery(isample).css "background", "#" + inputhex
      jQuery(aitem).css "border-color", "#" + inputhex  if C.show_color_on_border
    action_exit = ->
      return false  unless opened
      jQuery(slider).remove()
      jQuery(sb_sel).remove()
      jQuery(switcher).remove()
      click_flag = true
      switch C.effect
        when "zoom"
          jQuery(wrapper).animate
            width: "0px"
            height: "0px"
          , C.anim_speed, ->
            action_ok()
            jQuery(wrapper).remove()
        when "slide"
          jQuery(wrapper).slideUp C.anim_speed, ->
            action_ok()
            jQuery(wrapper).remove()
        when "fade"
          jQuery(wrapper).fadeTo C.anim_speed, 0, ->
            action_ok()
            jQuery(wrapper).remove()
        else
          action_ok()
          jQuery(wrapper).remove()
      opened = false
    action_ok = ->
      if userok
        a = "#" + rgb2hex(jQuery(inp_r).val() * 1, jQuery(inp_g).val() * 1, jQuery(inp_b).val() * 1)
        b = jQuery(inp_r).val() * 1 + "," + jQuery(inp_g).val() * 1 + "," + jQuery(inp_b).val() * 1
        if jQuery.trim(jQuery(inp_r).val()) is "" and jQuery.trim(jQuery(inp_g).val()) is "" and jQuery.trim(jQuery(inp_b).val()) is ""
          jQuery(isample).css "background", "url(" + root_path + "transp.gif) repeat"
          jQuery(aitem).val ""
        else
          jQuery(isample).css "background", a
          jQuery(aitem).css "border-color", a  if C.show_color_on_border
          if rgb_output
            jQuery(aitem).val b
          else
            jQuery(aitem).val a
        userok = false
        jQuery(aitem).trigger "change"
        C.callback_on_ok()
    draw_rgb = ->
      a = rgb2hsv(jQuery(inp_r).val() * 1, jQuery(inp_g).val() * 1, jQuery(inp_b).val() * 1)
      hue = -1 * (Math.round(a["h"] * 1 / 3) - 120)
      hue = 0  if hue < 0
      hue = 119  if hue > 119
      saturation = a["s"]
      brightness = a["v"]
      jQuery(slider).css("left", pos_huebox.left + "px").css "top", (pos_huebox.top + hue) + "px"
      init_positions()
      init_colors()
      jQuery(inp_hex).val rgb2hex(jQuery(inp_r).val() * 1, jQuery(inp_g).val() * 1, jQuery(inp_b).val() * 1)
    hex_valid_and_draw = ->
      a = true
      hexistr = ""
      hexistr = jQuery.trim(jQuery(inp_hex).val())
      switch hexistr.length
        when 1
          hexistr = "00000" + hexistr
        when 2
          hexistr = "0000" + hexistr
        when 3
          hexistr = "000" + hexistr
        when 4
          hexistr = "00" + hexistr
        when 5
          hexistr = "0" + hexistr
      if hexistr.length > 0
        i = 0

        while i < hexistr.length
          a = false  unless (hexistr.charAt(i) + "") of y
          i++
      if a
        if hexistr is ""
          hue = 119
          saturation = 0
          brightness = 0
        else
          b = hex2rgb(hexistr)
          jQuery(inp_r).val b["r"]
          jQuery(inp_g).val b["g"]
          jQuery(inp_b).val b["b"]
          b = rgb2hsv(b["r"], b["g"], b["b"])
          hue = -1 * (Math.round(b["h"] * 1 / 3) - 120)
          hue = 0  if hue < 0
          hue = 119  if hue > 119
          saturation = b["s"]
          brightness = b["v"]
        jQuery(slider).css("left", pos_huebox.left + "px").css "top", (pos_huebox.top + hue) + "px"
        init_positions()
        init_colors()
        if hexistr is ""
          jQuery(colsample).css("background-image", "url(" + root_path + "transp.gif)").css "background-repeat", "repeat"
          jQuery(isample).val("").css "background", "url(" + root_path + "transp.gif) repeat"
          jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) -20px 0 no-repeat"
          jQuery(wrapper).find("input").val ""
    update_inputs = ->
      a = hsb2rgb_hex(-1 * (hue - 119) * 3, saturation, brightness, "rgb")
      jQuery(inp_r).val Math.round(a["r"]) * 1
      jQuery(inp_g).val Math.round(a["g"]) * 1
      jQuery(inp_b).val Math.round(a["b"]) * 1
      jQuery(inp_hex).val rgb2hex(a["r"], a["g"], a["b"])
    hsb2rgb_hex = (a, b, c, d) ->
      h = a / 360
      s = b / 100
      v = c / 100
      e = new Array()
      f = undefined
      var_i = undefined
      var_1 = undefined
      var_2 = undefined
      var_3 = undefined
      var_r = undefined
      var_g = undefined
      if s is 0
        e["r"] = v * 255
        e["g"] = v * 255
        e["b"] = v * 255
      else
        f = h * 6
        var_i = Math.floor(f)
        var_1 = v * (1 - s)
        var_2 = v * (1 - s * (f - var_i))
        var_3 = v * (1 - s * (1 - (f - var_i)))
        if var_i is 0
          var_r = v
          var_g = var_3
          var_b = var_1
        else if var_i is 1
          var_r = var_2
          var_g = v
          var_b = var_1
        else if var_i is 2
          var_r = var_1
          var_g = v
          var_b = var_3
        else if var_i is 3
          var_r = var_1
          var_g = var_2
          var_b = v
        else if var_i is 4
          var_r = var_3
          var_g = var_1
          var_b = v
        else
          var_r = v
          var_g = var_1
          var_b = var_2
        e["r"] = Math.round(var_r * 255)
        e["g"] = Math.round(var_g * 255)
        e["b"] = Math.round(var_b * 255)
      if d is "hex"
        rgb2hex e["r"], e["g"], e["b"]
      else if d is "rgb"
        e
      else
        e
    hex2rgb = (h) ->
      a = new String()
      a = h
      a.toUpperCase()
      h = a
      i = undefined
      x = "0123456789ABCDEF"
      c = ""
      b = new Array()
      if h
        h = h.toUpperCase()
        i = 0
        while i < 6
          switch i
            when 0
              b["r"] = (16 * x.indexOf(h.charAt(i)) + x.indexOf(h.charAt(i + 1))) * 1
            when 2
              b["g"] = (16 * x.indexOf(h.charAt(i)) + x.indexOf(h.charAt(i + 1))) * 1
            when 4
              b["b"] = (16 * x.indexOf(h.charAt(i)) + x.indexOf(h.charAt(i + 1))) * 1
          i += 2
      b
    rgb2hsv = (a, c, d) ->
      e = 0
      maxrgb = 0
      delta = 0
      h = 0
      s = 0
      b = 0
      f = new Array()
      h = 0.0
      e = Math.min(Math.min(a, c), d)
      maxrgb = Math.max(Math.max(a, c), d)
      delta = (maxrgb - e)
      b = maxrgb
      unless maxrgb is 0.0
        s = 255.0 * delta / maxrgb
      else
        s = 0.0
      unless s is 0.0
        if a is maxrgb
          h = (c - d) / delta
        else
          if c is maxrgb
            h = 2.0 + (d - a) / delta
          else
            h = 4.0 + (a - c) / delta  if d is maxrgb
      else
        h = -1.0
      h = h * 60
      h = h + 360.0  if h < 0.0
      f["h"] = Math.round(h)
      f["s"] = Math.round(s * 100 / 255)
      f["v"] = Math.round(b * 100 / 255)
      f["h"] = 360  if f["h"] > 360
      f["s"] = 100  if f["s"] > 100
      f["v"] = 100  if f["v"] > 100
      f
    parsergb = (string) ->
      array = string.split(",")
      array
    rgb2hex = (r, g, b) ->
      a = new Array()
      a[0] = r
      a[1] = g
      a[2] = b
      c = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" ]
      d = ""
      i = 0

      while i < a.length
        dec = parseInt(a[i])
        d += c[parseInt(dec / 16)] + c[dec % 16]
        i++
      d
    init_positions = ->
      jQuery(slider).css("left", pos_huebox.left + "px").css "top", (pos_huebox.top + hue) + "px"
      jQuery(sb_sel).css("left", (pos_sbbox.left + Math.round(saturation * 1.3) - 4) + "px").css "top", (pos_sbbox.top + jQuery(sbbox).height() - 4 - Math.round(brightness * 1.3)) + "px"
    init_colors = ->
      jQuery(sbbox).css "background-color", "#" + hsb2rgb_hex(-1 * (hue - 119) * 3, 100, 100, "hex")
      jQuery(colsample).css("background-color", "#" + hsb2rgb_hex(-1 * (hue - 119) * 3, saturation, brightness, "hex")).css "background-image", "none"
      jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
    run_excolor_colorpicker = ->
      b = -1 * C.hue_bar * 20
      c = "<div id=\"excolor_sample_wrapper\"><div id=\"excolor_sample\"></div></div>"
      init_color()
      jQuery("body").append "<div id=\"excolor_colorpicker\"><div id=\"excolor_colorpicker_wrapper\"><div id=\"excolor_grad_wrap\"><div id=\"excolor_grad\"><div style=\"width:130px;height:130px;float:left;background-image:url(" + root_path + "bg.png);background-position:0 0;background-repeat:no-repeat;border:1px solid white;padding:0;margin:0;\"></div></div></div><div id=\"excolor_hue_wrap\" style=\"width:20px;height:130px;float:left;padding:15px 8px 0px 10px;margin:0;border:none;\"><div id=\"excolor_hue\" style=\"width:20px;height:130px;float:left;background:url(" + root_path + "hue.png) " + b + "px 0 no-repeat;margin:0;padding:0;border:none;\"></div></div><div id=\"excolor_data\" style=\"float:left;font-size:10px;font-family: Verdana, Arial, Helvetica, Sans-serif;width:66px;height:140px;margin:0;padding:0;border:none;\">" + c + "<div class=\"excolor_dataitem first\"><b class=\"label\">R</b><input id=\"excolor_r\" class=\"excolor_input excolor_rgb\" type=\"text\" size=\"3\" maxlength=\"3\" /></div><div class=\"excolor_dataitem\" style=\"float:left;padding:3px 0 0 0;margin:0;border:none;\"><b class=\"label\">G</b><input id=\"excolor_g\" class=\"excolor_input excolor_rgb\" type=\"text\" size=\"3\" maxlength=\"3\" /></div><div class=\"excolor_dataitem\"><b class=\"label\">B</b><input id=\"excolor_b\" class=\"excolor_input excolor_rgb\" type=\"text\" size=\"3\" maxlength=\"3\" /></div><div class=\"excolor_dataitem last\"><b class=\"label\">#</b><input id=\"excolor_hex\" class=\"excolor_input\" type=\"text\" size=\"6\" maxlength=\"6\" /></div><div style=\"width:66px;height:15px;padding:0;margin:0;border:none;float:left;\"><div id=\"excolor_ok\">OK</div><div id=\"excolor_close\">X</div></div></div></div></div><div id=\"excolor_picker\"></div><div id=\"excolor_slider\"></div><div id=\"excolor_switcher\"></div>"
      aitem_pos = jQuery(aitem).offset()
      wrapper = jQuery("body > div#excolor_colorpicker").css("left", aitem_pos.left + "px").css("top", (aitem_pos.top + jQuery(aitem).outerHeight()) + "px").mouseenter(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = true
        , 50)
      ).mouseleave(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = false
        , 50)
      )
      inp_hex = jQuery(wrapper).find("input#excolor_hex")
      switcher = jQuery("body > div#excolor_switcher")
      slider = jQuery("body > div#excolor_slider")
      sb_sel = jQuery("body > div#excolor_picker")
      switch C.effect
        when "zoom"
          jQuery(wrapper).css("width", "0px").css("height", "0px").show().animate
            width: "265px"
            height: "162px"
          , C.anim_speed, ->
            jQuery(this).show()
            jQuery("body > div#excolor_slider, body > div#excolor_picker").show()
            jQuery(switcher).show()
        when "slide"
          jQuery(wrapper).slideDown C.anim_speed, ->
            jQuery(this).show()
            jQuery("body > div#excolor_slider, body > div#excolor_picker").show()
            jQuery(switcher).show()
        when "fade"
          jQuery("body > div#excolor_colorpicker, body > div#excolor_slider, body > div#excolor_picker, body > div#excolor_switcher").fadeTo 1, 0, ->
            jQuery(this).show().fadeTo C.anim_speed, 1
        else
          jQuery(wrapper).show()
          jQuery(switcher).show()
          jQuery("body > div#excolor_slider, body > div#excolor_picker").show()
      huebox = jQuery(wrapper).find("div#excolor_hue")
      sbbox = jQuery(wrapper).find("div#excolor_grad div")
      colsample = jQuery(wrapper).find("#excolor_sample")
      inp_r = jQuery(wrapper).find("input#excolor_r")
      inp_g = jQuery(wrapper).find("input#excolor_g")
      inp_b = jQuery(wrapper).find("input#excolor_b")
      ok_but = jQuery(wrapper).find("#excolor_ok")
      close_but = jQuery(wrapper).find("#excolor_close")
      pos_wrap = jQuery(wrapper).offset()
      pos_sbbox = jQuery(sbbox).offset()
      pos_huebox = jQuery(huebox).offset()
      jQuery(switcher).click(->
        if jQuery.trim(jQuery(inp_r).val()) is "" and jQuery.trim(jQuery(inp_g).val()) is "" and jQuery.trim(jQuery(inp_b).val()) is ""
          jQuery(colsample).css "background-image", "none"
          jQuery(this).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
          update_inputs()
        else
          jQuery(colsample).css("background-image", "url(" + root_path + "transp.gif)").css "background-repeat", "repeat"
          jQuery(wrapper).find("input").val ""
          jQuery(this).css "background", "url(" + root_path + "transp0.gif) -20px 0 no-repeat"
      ).css("left", (pos_huebox.left - 1) + "px").css("top", (pos_huebox.top - 15) + "px").mouseenter(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = true
        , 50)
      ).mouseleave ->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = false
        , 50)

      jQuery(slider).mouseenter(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = true
        , 50)
      ).mouseleave ->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = false
        , 50)

      jQuery(sb_sel).mouseenter(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = true
        , 50)
      ).mouseleave(->
        clearTimeout click_to
        click_to = setTimeout(->
          click_flag = false
        , 50)
      ).dblclick (e) ->
        jQuery(ok_but).click()

      jQuery(sb_sel).mousedown((e) ->
        pos_sel = jQuery(this).offset()
        correct_x = e.pageX - pos_sel.left
        correct_y = e.pageY - pos_sel.top
        j = this
        jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
        e.preventDefault()
      ).click (e) ->

      jQuery(slider).mousedown (e) ->
        pos_slider = jQuery(this).offset()
        correct_x = e.pageX - pos_slider.left
        correct_y = e.pageY - pos_slider.top
        moved_slider = this
        jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
        e.preventDefault()

      jQuery(huebox).mousedown (e) ->
        if e.pageY >= (pos_huebox.top + 5) and e.pageY <= ((pos_huebox.top + jQuery(huebox).height()) - 6)
          hue = e.pageY - pos_huebox.top - 5
          hue = 0  if hue < 0
          hue = 119  if hue > 119
          jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
          init_positions()
          init_colors()
          update_inputs()
          pos_slider = jQuery(slider).offset()
          correct_x = e.pageX - pos_slider.left
          correct_y = e.pageY - pos_slider.top
          moved_slider = slider
          e.preventDefault()

      jQuery(sbbox).mousedown (e) ->
        saturation = Math.round((e.pageX - pos_sbbox.left - 1) / 1.3)
        saturation = 100  if saturation > 100
        saturation = 1  if saturation < 1
        brightness = -1 * (Math.round((e.pageY - pos_sbbox.top - 1) / 1.3) - 100)
        brightness = 100  if brightness > 100
        brightness = 1  if brightness < 1
        jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
        init_positions()
        jQuery(colsample).css("background-color", "#" + hsb2rgb_hex(-1 * (hue - 119) * 3, saturation, brightness, "hex")).css "background-image", "none"
        update_inputs()
        j = sb_sel
        pos_sel = jQuery(j).offset()
        correct_x = e.pageX - pos_sel.left
        correct_y = e.pageY - pos_sel.top
        e.preventDefault()

      jQuery(wrapper).find("input.excolor_input").keypress((a) ->
        if jQuery(this).hasClass("excolor_rgb")
          a.preventDefault()  if ((String.fromCharCode(a.which) * 1) of w) and (a.which of z)
        else
          a.preventDefault()  if (String.fromCharCode(a.which) not of y) and (a.which not of z)
      ).change(->
        if jQuery(this).hasClass("excolor_rgb")
          jQuery(this).val "0"  if jQuery(this).val() is ""
          jQuery(this).val "0"  if isNaN(jQuery(this).val() * 1)
          jQuery(this).val "255"  if jQuery(this).val() * 1 > 255
          jQuery(this).val "0"  if jQuery(this).val() * 1 < 0
          draw_rgb()
        else
          hex_valid_and_draw()
      ).keyup ->
        if jQuery(this).hasClass("excolor_rgb")
          jQuery(this).val "0"  if jQuery(this).val() is ""
          jQuery(this).val "0"  if isNaN(jQuery(this).val() * 1)
          jQuery(this).val "255"  if jQuery(this).val() * 1 > 255
          jQuery(this).val "0"  if jQuery(this).val() * 1 < 0
          draw_rgb()
        else
          hex_valid_and_draw()

      inp_hex[0].onpaste = inp_hex[0].oninput = (e) ->
        clearTimeout hexto
        hexto = setTimeout(->
          hex_valid_and_draw()
        , 100)

      inp_r[0].onpaste = inp_r[0].oninput = inp_g[0].onpaste = inp_g[0].oninput = inp_b[0].onpaste = inp_b[0].oninput = (e) ->
        jQuery(this).val "0"  if jQuery(this).val() is ""
        jQuery(this).val "0"  if isNaN(jQuery(this).val() * 1)
        jQuery(this).val "255"  if jQuery(this).val() * 1 > 255
        jQuery(this).val "0"  if jQuery(this).val() * 1 < 0
        clearTimeout hexto
        hexto = setTimeout(->
          draw_rgb()
        , 100)

      jQuery(ok_but).click(->
        userok = true
        action_exit()
      ).mouseenter(->
        jQuery(this).css "background-position", "0 -15px"
      ).mouseleave ->
        jQuery(this).css "background-position", "0 0"

      jQuery(close_but).click(->
        action_exit()
      ).mouseenter(->
        jQuery(this).css "background-position", "-47px -15px"
      ).mouseleave ->
        jQuery(this).css "background-position", "-47px 0"

      init_positions()
      jQuery(inp_hex).val inputhex
      hex_valid_and_draw()
      opened = true
      if inputhex is ""
        jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) -20px 0 no-repeat"
      else
        jQuery(switcher).css "background", "url(" + root_path + "transp0.gif) 0 0 no-repeat"
    j = "mel"
    moved_slider = "mel"
    correct_x = 0
    correct_y = 0
    pos_sel = 0
    pos_slider = 0
    huebox = 0
    wrapper = 0
    pos_wrap = 0
    pos_huebox = 0
    hue = 0
    sbbox = 0
    sb_sel = 0
    saturation = 1
    brightness = 1
    slider = 0
    colsample = 0
    inp_r = 0
    inp_g = 0
    inp_b = 0
    inp_hex = 0
    hexto = 0
    ok_but = 0
    close_but = 0
    aitem = this
    aitem_pos = jQuery(this).offset()
    opened = false
    isample = 0
    click_flag = 0
    click_to = 0
    userok = false
    parsex = ""
    inputhex = ""
    rgb_input = /\d+\,\d+\,\d+/i
    rgb_output = C.rgb_output
    looper = 0
    switcher = 0
    moved_slider = jQuery("script")
    unless C.root_path
      i = 0

      while i < moved_slider.length
        j = "" + jQuery(moved_slider[i]).attr("src")
        j = j.toLowerCase()
        j = j.split("jquery.excolor.js")
        root_path = j[0]  if j.length is 2
        i++
    else
      root_path = C.root_path
    k = new Image()
    l = new Image()
    m = new Image()
    n = new Image()
    o = new Image()
    p = new Image()
    q = new Image()
    t = new Image()
    k.src = root_path + "sel.gif"
    l.src = root_path + "slider.gif"
    m.src = root_path + "bg.png"
    n.src = root_path + "hue.png"
    o.src = root_path + "ok.png"
    p.src = root_path + "shbg.png"
    q.src = root_path + "transp0.gif"
    t.src = root_path + "transp.gif"
    moved_slider = "mel"
    j = "mel"
    jQuery(aitem).mouseenter(->
      clearTimeout click_to
      click_to = setTimeout(->
        click_flag = true
      , 100)
    ).mouseleave ->
      clearTimeout click_to
      click_to = setTimeout(->
        click_flag = false
      , 100)

    jQuery(aitem).wrap "<span style=\"margin:0;padding:0\"></span>"  if C.color_box
    u = ""
    rad3px = ""
    radwrap = ""
    shadow = ""
    backlight = ""
    if C.round_corners
      u = "-khtml-border-radius:2px;-moz-border-radius:2px;-webkit-border-radius:2px;border-radius:2px;"
      rad3px = "-khtml-border-radius:2px;-moz-border-radius:2px;-webkit-border-radius:2px;border-radius:2px;"
      radwrap = "-khtml-border-radius: 0 2px 2px 2px;-moz-border-radius: 0 2px 2px 2px;-webkit-border-radius: 0 2px 2px 2px;border-radius: 0 2px 2px 2px;"
    shadow = "box-shadow:0 " + C.shadow_size + "px " + (C.shadow_size * 2) + "px 0 " + C.shadow_color + ";-webkit-box-shadow:0 " + C.shadow_size + "px " + (C.shadow_size * 2) + "px 0 " + C.shadow_color + ";-moz-box-shadow:0 " + C.shadow_size + "px " + (C.shadow_size * 2) + "px 0 " + C.shadow_color + ";"  if C.shadow
    backlight = "background-position:0 0;background-repeat:no-repeat;background-image:url(" + root_path + "shbg.png);"  if C.backlight
    w = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
    w[8] = 8
    w[46] = 46
    y = new Array()
    y["0"] = 1
    y["1"] = 1
    y["2"] = 1
    y["3"] = 1
    y["4"] = 1
    y["5"] = 1
    y["6"] = 1
    y["7"] = 1
    y["8"] = 1
    y["9"] = 1
    y["A"] = 1
    y["B"] = 1
    y["C"] = 1
    y["D"] = 1
    y["E"] = 1
    y["F"] = 1
    y["a"] = 1
    y["b"] = 1
    y["c"] = 1
    y["d"] = 1
    y["e"] = 1
    y["f"] = 1
    z = new Array()
    z[0] = "system keys"
    z[8] = "backspace"
    z[118] = "ctrl v"
    z[86] = "ctrl v"
    z[99] = "ctrl c"
    z[67] = "ctrl c"
    A = " " + Math.random()
    A = A.split(".")
    A = "mc" + A[1]
    B = jQuery(aitem).parent().offset()
    jQuery(aitem).parent().append "<input class=\"excolor_clrbox\" readonly=\"readonly\" id=\"" + A + "\" type=\"text\" />"
    jQuery(aitem).clone().show().addClass("mds" + A).css("position", "absolute").css("visibility", "hidden").appendTo "body"
    setTimeout (->
      a = jQuery("body > .mds" + A)
      jQuery(a).remove()
    ), 300
    isample = jQuery(aitem).parent().find("#" + A).mouseenter(->
      clearTimeout click_to
      click_to = setTimeout(->
        click_flag = true
      , 50)
    ).mouseleave(->
      clearTimeout click_to
      click_to = setTimeout(->
        click_flag = false
      , 50)
    ).focus(->
      jQuery(aitem).focus()
    )
    if C.color_box
      setTimeout (->
        jQuery(isample).show()
      ), 150
    init_color()
    setTimeout (->
      aitem_pos = jQuery(aitem).offset()
    ), 200
    jQuery(document).mouseup((e) ->
      j = "mel"
      moved_slider = "mel"
    ).mousemove((e) ->
      unless j is "mel"
        e.preventDefault()
        a = 0
        tty = 0
        a = e.pageX - correct_x
        a = pos_sbbox.left - 4  if a < (pos_sbbox.left - 4)
        a = pos_sbbox.left + 125  if a > (pos_sbbox.left + 125)
        tty = e.pageY - correct_y
        tty = pos_sbbox.top - 4  if tty < (pos_sbbox.top - 4)
        tty = pos_sbbox.top + 125  if tty > (pos_sbbox.top + 125)
        jQuery(j).css("left", a + "px").css "top", tty + "px"
        brightness = -1 * (Math.round((tty - pos_sbbox.top + 5) / 1.3) - 100) + 1
        saturation = Math.round((a - pos_sbbox.left + 5) / 1.3)
        brightness = 0  if brightness is 1
        saturation = 0  if saturation is 1
        jQuery(colsample).css("background-color", "#" + hsb2rgb_hex(-1 * (hue - 119) * 3, saturation, brightness, "hex")).css "background-image", "none"
        update_inputs()
      unless moved_slider is "mel"
        e.preventDefault()
        hue = e.pageY - pos_huebox.top - correct_y
        hue = 0  if hue < 0
        hue = 119  if hue > 119
        jQuery(moved_slider).css("left", pos_huebox.left + "px").css "top", (pos_huebox.top + hue) + "px"
        init_colors()
        update_inputs()
    ).keydown((a) ->
      if a.keyCode is "27"
        a.preventDefault()
        action_exit()
      if a.keyCode is "13"
        a.preventDefault()
        jQuery(ok_but).click()
    ).click ->
      action_exit()  unless click_flag

    jQuery(aitem).click(->
      unless opened
        jQuery("body > div#excolor_slider, body > div#excolor_picker, body > div#excolor_colorpicker").stop().remove()
        setTimeout (->
          run_excolor_colorpicker()
        ), 50
    ).keyup ->
      if opened
        init_color()
        update_inputs()
        init_positions()
        jQuery(inp_hex).val inputhex
        hex_valid_and_draw()

    jQuery(isample).click ->
      jQuery(aitem).click()

    jQuery(isample).click()  if C.demo_mode