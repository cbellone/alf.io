--
-- This file is part of alf.io.
--
-- alf.io is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- alf.io is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with alf.io.  If not, see <http://www.gnu.org/licenses/>.
--

create type JOB_STATUS as enum ('SCHEDULED', 'RUNNING', 'EXECUTED', 'FAILED');

create table async_extension_queue (
    id bigserial primary key,
    extension_path text not null,
    organization_id_fk integer not null constraint "org_extension_queue_fk" references organization(id),
    payload text not null,
    status JOB_STATUS not null default 'SCHEDULED',
    scheduled_ts timestamp not null default now(),
    last_attempt_ts timestamp,
    num_retries int not null default 0
);
