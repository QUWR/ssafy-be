package com.ssafy.exam.controller;

import com.ssafy.exam.model.dto.Member;
import com.ssafy.exam.model.dto.MemberDeleteResponse;
import com.ssafy.exam.model.dto.MemberLoginRequest;
import com.ssafy.exam.model.dto.MemberLoginResponse;
import com.ssafy.exam.model.dto.MemberProfileResponse;
import com.ssafy.exam.model.dto.MemberRegisterResponse;
import com.ssafy.exam.model.dto.MemberUpdateResponse;
import com.ssafy.exam.model.service.MemberService;
import com.ssafy.exam.security.JwtTokenProvider;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/member")
public class MemberController {

    private final MemberService memberService;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider tokenProvider;

    public MemberController(MemberService memberService, AuthenticationManager authenticationManager, JwtTokenProvider tokenProvider) {
        this.memberService = memberService;
        this.authenticationManager = authenticationManager;
        this.tokenProvider = tokenProvider;
    }

    @PostMapping("/register")
    public ResponseEntity<MemberRegisterResponse> register(@RequestBody Member member) {
        boolean success = memberService.register(member);
        if (success) {
            return ResponseEntity.ok(new MemberRegisterResponse("회원가입에 성공했습니다.", null));
        } else {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(new MemberRegisterResponse(null, "이미 등록된 이메일입니다."));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<MemberLoginResponse> login(@RequestBody MemberLoginRequest loginRequest) {
        String email = loginRequest.getEmail();
        String password = loginRequest.getPassword();

        try {
            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(email, password)
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);
            String jwt = tokenProvider.createToken(authentication);
            return ResponseEntity.ok(new MemberLoginResponse(jwt, null));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new MemberLoginResponse(null, "로그인 실패: " + e.getMessage()));
        }
    }

    @GetMapping("/profile")
    public ResponseEntity<MemberProfileResponse> showProfile() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new MemberProfileResponse(null, "로그인이 필요합니다."));
        }
        String userEmail = authentication.getName();
        Member member = memberService.getMemberByEmail(userEmail);
        return ResponseEntity.ok(new MemberProfileResponse(member, null));
    }

    @PutMapping("/update")
    public ResponseEntity<MemberUpdateResponse> updateProfile(@RequestBody Member updatedMember) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userEmail = authentication.getName();
        Member loginMember = memberService.getMemberByEmail(userEmail);

        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new MemberUpdateResponse(null, "로그인이 필요합니다."));
        }

        updatedMember.setMno(loginMember.getMno());
        updatedMember.setEmail(loginMember.getEmail());
        updatedMember.setRole(loginMember.getRole());

        boolean success = memberService.updateMember(updatedMember);
        if (success) {
            return ResponseEntity.ok(new MemberUpdateResponse("프로필이 성공적으로 업데이트되었습니다.", null));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new MemberUpdateResponse(null, "프로필 업데이트에 실패했습니다."));
        }
    }

    @DeleteMapping("/delete")
    public ResponseEntity<MemberDeleteResponse> deleteAccount() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userEmail = authentication.getName();
        Member loginMember = memberService.getMemberByEmail(userEmail);

        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new MemberDeleteResponse(null, "로그인이 필요합니다."));
        }

        memberService.deleteMember(loginMember.getMno());
        SecurityContextHolder.clearContext();
        return ResponseEntity.ok(new MemberDeleteResponse("회원 탈퇴가 성공적으로 처리되었습니다.", null));
    }
}