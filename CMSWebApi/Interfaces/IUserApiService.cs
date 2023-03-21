﻿using CMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMSWebApi.Interfaces
{
    public interface IUserApiService
    {
        AuthenticateResponse AuthenticateUser(WebApiUserLoginEntity loginRequest);
        LoginResponse GetById(int userId);
    }
}