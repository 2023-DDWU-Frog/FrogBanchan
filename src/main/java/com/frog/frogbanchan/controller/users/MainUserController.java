package com.frog.frogbanchan.controller.users;

import com.frog.frogbanchan.controller.TeamSession;
import com.frog.frogbanchan.controller.UserSession;
import com.frog.frogbanchan.domain.Team;
import com.frog.frogbanchan.service.FrogBanchanFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@SessionAttributes("teamSession")
public class MainUserController {

    private FrogBanchanFacade frogBanchan;

    @Autowired
    public void setFrogBanchan(FrogBanchanFacade frogBanchan) {
        this.frogBanchan = frogBanchan;
    }

    @RequestMapping("/user/main")
    public ModelAndView handleRequest1(@SessionAttribute("userSession") UserSession userSession)
            throws Exception {
        ModelAndView mav = new ModelAndView("/user/mainForCommon");

        String user = userSession.getUser().getUsername();

        List<Team> teamList = frogBanchan.findTeamList(user);
        Map<Integer, Integer> teamMap = new HashMap<>();
        for (Team team : teamList) {
            teamMap.put(team.getTeamId(), frogBanchan.findTeamMembers(team.getTeamId()).size());
        }
        mav.addObject("teamList", teamList);
        mav.addObject("teamMap", teamMap);

        List<String> hateTagList = frogBanchan.findTagsByUsername(user);
        mav.addObject("hateTagList", hateTagList);

        return mav;
    }

    @RequestMapping("/user/myPage")
    public ModelAndView handleRequest2(@SessionAttribute("userSession") UserSession userSession)
            throws Exception {
        ModelAndView mav = new ModelAndView("/user/myPageForCommon");

        String user = userSession.getUser().getUsername();
        mav.addObject("user", userSession.getUser());
        mav.addObject("history", frogBanchan.findHistoryList(user));
//        mav.addObject("reservation", frogBanchan.findHistoryList(user));

        return mav;
    }

    @RequestMapping("/team/main/{teamId}")
    public String handleRequest3(@PathVariable("teamId") int teamId,
                                Model model) throws Exception {
        model.addAttribute(new TeamSession(frogBanchan.findTeam(teamId)));
        model.addAttribute("memberList", frogBanchan.findTeamMembers(teamId));
        model.addAttribute("team", frogBanchan.findTeam(teamId));

        return "/team/teamPage";
    }

    //식구 리스트 조회
    @RequestMapping("/party/list")
    public ModelAndView handleRequest() throws Exception {
        return new ModelAndView("/party/list", "partyList", frogBanchan.findPartyList());
    }


}
