package com.frog.frogbanchan.controller.history;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.frog.frogbanchan.controller.TeamSession;
import com.frog.frogbanchan.domain.History;
import com.frog.frogbanchan.domain.PlaceMenu;
import com.frog.frogbanchan.domain.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.frog.frogbanchan.controller.UserSession;
import com.frog.frogbanchan.service.FrogBanchanFacade;

import java.util.List;

@Controller
public class HistoryController {

    @Value("/history/historyForm")
    private String FORM_VIEW;
    @Value("/history/list")
    private String LIST_VIEW;

    private FrogBanchanFacade frogBanchan;
    @Autowired
    public void setFrogBanchan(FrogBanchanFacade frogBanchan) {
        this.frogBanchan = frogBanchan;
    }

    //기록 리스트 조회
    @RequestMapping("/history/list")
    public ModelAndView handleRequest(
            @SessionAttribute("userSession") UserSession userSession) throws Exception {
        ModelAndView mav = new ModelAndView("/history/myHistory");

        String username = userSession.getUser().getUsername();
        List<History> historyList = frogBanchan.findHistoryList(username);
        for (History history : historyList) {
            String placeAndMenu = frogBanchan.findPlaceById(history.getPlaceId()).getName();
            placeAndMenu += "ANDMENU";
            if (history.getPlaceMenuId() != 0) {
                placeAndMenu += frogBanchan.findMenuByPlaceMenuId(history.getPlaceMenuId());
            }
            history.setPlaceId(placeAndMenu);
        }

        mav.addObject("historyList", historyList);

        return mav;
    }

    @ModelAttribute("historyForm")
    public HistoryForm createHistoryForm() {
        return new HistoryForm();
    }


    //기록 생성
    @GetMapping("/history/create")
    public String createHistory(HttpServletRequest request, HttpSession session, @RequestParam(value="placeId") String placeId, Model model) {
        UserSession userSession = (UserSession) request.getSession().getAttribute("userSession");
        TeamSession teamSession = (TeamSession) request.getSession().getAttribute("teamSession");

        History history = new History();

        if(teamSession!=null && teamSession.getSelectedMembers()!=null) {
            List<Users> memberList = teamSession.getSelectedMembers();
            for (Users member : memberList) {
                history.setUsername(member.getUsername());

                history.setPlaceId(placeId);

                frogBanchan.insertHistory(history);
            }
        }
        else {
            String username = userSession.getUser().getUsername();
            history.setUsername(username);

            history.setPlaceId(placeId);

            frogBanchan.insertHistory(history);
        }

        // 팀 or 개인 여부
        // 팀원 다 history 생성

        model.addAttribute(placeId);

        model.addAttribute("history", history);
        return "redirect:/recommend/result?placeId="+placeId;
    }

    //기록 수정
    @GetMapping("/history/update")
    public String showForm(@RequestParam(value="historyId") int historyId, Model model, @ModelAttribute("historyForm") HistoryForm historyForm) {
        History history = frogBanchan.findHistory(historyId);
        if (history == null) {
            return LIST_VIEW;
        }
        String placeId = history.getPlaceId();
        List<PlaceMenu> placeMenuList = frogBanchan.findMenuListByPlaceId(placeId);
        model.addAttribute("placeMenuList", placeMenuList);
        model.addAttribute("history", history);
        return FORM_VIEW;
    }

    //기록 수정 처리
    @PostMapping("/history/update")
    public String updateHistory(
            HttpServletRequest request, HttpSession session,
            @ModelAttribute("historyForm") HistoryForm historyForm, @RequestParam("historyId") int historyId, BindingResult bindingResult, Model model) throws Exception {
        History history = historyForm.getHistory();
        history.setHistoryId(historyId);
        frogBanchan.updateHistory(history);
        model.addAttribute("history", history);


        return "redirect:/history/list";
    }

    //기록 삭제
    @RequestMapping("/history/delete")
    public String handleRequest(
            @RequestParam("historyId") int historyId,
            ModelMap model) throws Exception {
        frogBanchan.deleteHistory(historyId);

        return "redirect:/history/list";
    }

}