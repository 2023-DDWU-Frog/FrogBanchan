package com.frog.frogbanchan.controller.party;

import com.frog.frogbanchan.domain.Apply;
import com.frog.frogbanchan.domain.Party;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.frog.frogbanchan.controller.UserSession;
import com.frog.frogbanchan.service.FrogBanchanFacade;
import com.frog.frogbanchan.service.validator.PartyFormValidator;

@Controller
public class PartyFormController { 
    @Value("/party/partyForm")
	private String FORM_VIEW;
    
	private FrogBanchanFacade frogBanchan;
    @Autowired
    public void setFrogBanchan(FrogBanchanFacade frogBanchan) {
        this.frogBanchan = frogBanchan;
    }
	
	//식구 상세정보 조회
	@GetMapping("/party/view")
	@ModelAttribute("applyList")
	public ModelAndView findParty(@ModelAttribute("applyForm") ApplyForm applyForm, @RequestParam("partyId") int partyId, HttpSession session) {
		Party party = frogBanchan.findParty(partyId);
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/party/view");
		mav.addObject("party", party);
		mav.addObject("applyList", frogBanchan.findApplyByPartyId(partyId));
		mav.addObject("applyForm", applyForm);
		
		return mav;
	}
	
	@ModelAttribute("partyForm")
	public PartyForm createPartyForm() {
		return new PartyForm();
	}

	@Autowired
    private PartyFormValidator validator;
    public void setValidator(PartyFormValidator validator) {
        this.validator = validator;
    }
    
    @ModelAttribute("partyForm")
    public PartyForm formBacking(@RequestParam(value="partyId") int partyId){
    	PartyForm partyForm = new PartyForm(frogBanchan.findParty(partyId));
    	
    	return partyForm;
    	
    }

    //식구 모집 생성
	@GetMapping("/party/create")
	public String showForm(HttpServletRequest request, HttpSession session, Model model) {
		UserSession userSession = (UserSession) request.getSession().getAttribute("userSession");
		Party party = new Party();
	
		String creator = userSession.getUser().getUsername();
		party.setCreator(creator);
		
		
		model.addAttribute("party", party);
        return FORM_VIEW;
    }

	//식구 모집 생성 처리
	@PostMapping("/party/create")
	public String createParty(
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("partyForm") PartyForm partyForm, BindingResult bindingResult, Model model) throws Exception {
		Party party = partyForm.getParty();

		validator.validate(partyForm, bindingResult);
		if (bindingResult.hasErrors()) {
			return FORM_VIEW;
		}

		frogBanchan.insertParty(party);
		party.setPartyId(party.getPartyId());
		model.addAttribute("party", party);
		
		return "redirect:/party/list";
	}
 
	//식구 모집 수정
	@GetMapping("/party/update")
    public String showForm(@RequestParam(value="partyId") int partyId, Model model, @ModelAttribute("partyForm") PartyForm partyForm, HttpServletRequest request) {
		Party party = frogBanchan.findParty(partyId);
		if (party == null) {
			return "redirect:/party/list";
		}

		model.addAttribute("party", party);
        return "/party/partyUpdateForm";
    }
	
	//식구 모집 수정 처리
	@PostMapping("/party/update")
	public String updateParty(
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("partyForm") PartyForm partyForm, BindingResult bindingResult, Model model) throws Exception {
		Party party = partyForm.getParty();

		validator.validate(partyForm, bindingResult);
		if (bindingResult.hasErrors()) {
			return "/party/partyUpdateForm";
		}

		frogBanchan.updateParty(party);
		model.addAttribute("party", party);
		
		return "redirect:/party/view?=" + party.getPartyId();
	}
	
	//식구 모집 삭제
	@RequestMapping("/party/delete")
	public String handleRequest(
			@RequestParam("partyId") int partyId, 
			ModelMap model) throws Exception {
		frogBanchan.deleteApplyByPartyId(partyId);
		frogBanchan.deleteParty(partyId);
		
		return "redirect:/party/list";
	}

}